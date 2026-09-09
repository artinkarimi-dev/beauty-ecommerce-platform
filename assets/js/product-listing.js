(function () {
    "use strict";

    const scriptUrl = document.currentScript ? document.currentScript.src : window.location.href;
    const defaultApiUrl = new URL("../../api/products.php", scriptUrl).href;
    const defaultSearchUrl = new URL("../../api/search.php", scriptUrl).href;
    const defaultSessionUrl = new URL("../../api/session.php", scriptUrl).href;
    const defaultCartUrl = new URL("../../api/cart.php", scriptUrl).href;
    const sortMap = {
        newest: "newest",
        popular: "newest",
        cheap: "price_asc",
        expensive: "price_desc",
        price_asc: "price_asc",
        price_desc: "price_desc",
        name_asc: "name_asc",
        name_desc: "name_desc"
    };
    let csrfToken = null;
    let csrfRequest = null;

    function createStatus(message) {
        const status = document.createElement("div");
        status.className = "product-status";
        status.textContent = message;
        return status;
    }

    function formatPrice(amount) {
        if (amount === null || amount === undefined || amount === "") {
            return "تماس بگیرید";
        }

        return new Intl.NumberFormat("fa-IR").format(Number(amount)) + " تومان";
    }

    function isSafeImagePath(value) {
        if (!value || /[\u0000-\u001f]/.test(value)) {
            return false;
        }

        if (/^(?:javascript|data|vbscript):/i.test(value)) {
            return false;
        }

        if (value.indexOf("//") === 0 || value.indexOf(":") !== -1) {
            return false;
        }

        return /^(?:\.\/|\.\.\/|\/|assets\/|[A-Za-z0-9_\-./]+\.(?:png|jpe?g|webp|gif))/.test(value);
    }

    function appendImageContent(box, product) {
        const imageValue = product.image || "○";

        if (!isSafeImagePath(imageValue)) {
            box.textContent = imageValue;
            return;
        }

        const image = document.createElement("img");
        image.src = imageValue;
        image.alt = product.name || "";
        image.loading = "lazy";
        image.decoding = "async";
        image.addEventListener("error", function () {
            const fallback = document.createElement("div");
            fallback.className = "image-fallback";
            fallback.textContent = product.name || "تصویر محصول";
            image.replaceWith(fallback);
        }, { once: true });

        box.appendChild(image);
    }

    function createSimpleCard(product, options) {
        const card = document.createElement("article");
        card.className = "product-card";
        card.dataset.productId = String(product.id);
        card.dataset.price = product.price_amount === null ? "" : String(product.price_amount);

        const image = document.createElement("div");
        image.className = "product-image";
        appendImageContent(image, product);

        const info = document.createElement("div");
        info.className = "product-info";

        const category = document.createElement("span");
        category.className = "product-category";
        category.textContent = product.category.name;

        const title = document.createElement("h3");
        title.className = "product-title";
        title.textContent = product.name;

        const description = document.createElement("p");
        description.className = "product-description";
        description.textContent = product.description;

        const bottom = document.createElement("div");
        bottom.className = "product-bottom";

        const price = document.createElement("span");
        price.className = "price";
        price.textContent = product.price_label || formatPrice(product.price_amount);

        const button = document.createElement("button");
        button.className = "add-btn";
        button.type = "button";
        button.textContent = options.buttonText;
        button.dataset.productSlug = product.slug;

        bottom.append(price, button);
        info.append(category, title, description, bottom);
        card.append(image, info);

        return card;
    }

    function getSortValue(select) {
        if (!select) {
            return "newest";
        }

        return sortMap[select.value] || sortMap[select.dataset.defaultSort] || "newest";
    }

    function getSearchInput(grid) {
        if (grid.dataset.searchTarget) {
            return document.querySelector(grid.dataset.searchTarget);
        }

        const formInput = document.querySelector("form.search input[type='search'], form.search input[name='q']");

        if (formInput) {
            return formInput;
        }

        return document.querySelector(".search input[type='search'], .search input[name='q'], .search input");
    }

    function setGridStatus(grid, message) {
        grid.replaceChildren(createStatus(message));
    }

    async function getCsrfToken(sessionUrl, forceRefresh) {
        if (csrfToken && !forceRefresh) {
            return csrfToken;
        }

        if (csrfRequest && !forceRefresh) {
            return csrfRequest;
        }

        csrfRequest = fetch(sessionUrl, {
            headers: {
                Accept: "application/json"
            },
            credentials: "same-origin"
        })
            .then(function (response) {
                if (!response.ok) {
                    throw new Error("Session request failed");
                }

                return response.json();
            })
            .then(function (payload) {
                if (!payload || payload.success !== true || !payload.data || !payload.data.csrf_token) {
                    throw new Error("Session response is invalid");
                }

                csrfToken = payload.data.csrf_token;
                return csrfToken;
            })
            .finally(function () {
                csrfRequest = null;
            });

        return csrfRequest;
    }

    async function addToCart(productId, options) {
        let token = await getCsrfToken(options.sessionUrl, false);
        let response = await sendCartRequest(productId, token, options.cartUrl);

        if (response.status === 403) {
            csrfToken = null;
            token = await getCsrfToken(options.sessionUrl, true);
            response = await sendCartRequest(productId, token, options.cartUrl);
        }

        const payload = await response.json();

        if (!response.ok || !payload || payload.success !== true) {
            throw new Error("Cart request failed");
        }

        if (payload.data && payload.data.csrf_token) {
            csrfToken = payload.data.csrf_token;
        }

        document.dispatchEvent(new CustomEvent("alkamoone:cart-updated", {
            detail: payload.data || {}
        }));

        return payload.data;
    }

    function sendCartRequest(productId, token, cartUrl) {
        return fetch(cartUrl, {
            method: "POST",
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json",
                "X-CSRF-Token": token
            },
            credentials: "same-origin",
            body: JSON.stringify({
                product_id: productId,
                quantity: 1
            })
        });
    }

    function initListing(grid) {
        if (grid.dataset.productListingReady === "true") {
            return;
        }

        grid.dataset.productListingReady = "true";

        const category = grid.dataset.category;

        if (!category) {
            setGridStatus(grid, "دسته‌بندی محصول مشخص نشده است.");
            return;
        }

        const sort = document.querySelector(grid.dataset.sortTarget || "[data-product-sort]");
        const options = {
            apiUrl: grid.dataset.apiUrl || defaultApiUrl,
            searchUrl: grid.dataset.searchUrl || defaultSearchUrl,
            sessionUrl: grid.dataset.sessionUrl || defaultSessionUrl,
            cartUrl: grid.dataset.cartUrl || defaultCartUrl,
            countTarget: grid.dataset.countTarget ? document.querySelector(grid.dataset.countTarget) : null,
            category,
            perPage: grid.dataset.perPage || "24",
            buttonText: grid.dataset.buttonText || "مشاهده",
            cartEnabled: grid.dataset.cartEnabled === "true"
        };
        let activeRequest = null;
        let currentPage = 1;
        let activeQuery = "";
        let searchTimer = null;

        async function loadProducts(page) {
            currentPage = page;

            if (activeRequest) {
                activeRequest.abort();
            }

            activeRequest = typeof AbortController !== "undefined" ? new AbortController() : null;
            setGridStatus(grid, "در حال دریافت محصولات...");

            const isSearch = activeQuery.length >= 2;
            const url = new URL(isSearch ? options.searchUrl : options.apiUrl);

            if (isSearch) {
                url.searchParams.set("q", activeQuery);
            }

            url.searchParams.set("category", options.category);
            url.searchParams.set("page", String(currentPage));
            url.searchParams.set("per_page", options.perPage);
            url.searchParams.set("sort", getSortValue(sort));

            try {
                const response = await fetch(url.href, {
                    headers: {
                        Accept: "application/json"
                    },
                    signal: activeRequest ? activeRequest.signal : undefined
                });
                const payload = await response.json();

                if (!response.ok || payload.success !== true) {
                    throw new Error("API error");
                }

                render(payload.data.products || []);
            } catch (error) {
                if (error.name === "AbortError") {
                    return;
                }

                setGridStatus(grid, "در حال حاضر امکان دریافت محصولات وجود ندارد.");
            }
        }

        function render(products) {
            if (options.countTarget) {
                options.countTarget.textContent = new Intl.NumberFormat("fa-IR").format(products.length);
            }

            grid.replaceChildren();

            if (products.length === 0) {
                setGridStatus(grid, "محصولی برای این دسته ثبت نشده است.");
                return;
            }

            products.forEach(function (product) {
                grid.appendChild(createSimpleCard(product, options));
            });
        }

        if (sort) {
            sort.addEventListener("change", function () {
                loadProducts(1);
            });
        }

        const searchInput = getSearchInput(grid);

        if (searchInput) {
            const searchForm = searchInput.closest("form");

            function queueSearch(delay) {
                window.clearTimeout(searchTimer);
                searchTimer = window.setTimeout(function () {
                    const query = searchInput.value.trim();

                    if (query.length === 1) {
                        activeQuery = query;
                        setGridStatus(grid, "برای جستجو حداقل دو کاراکتر وارد کنید.");
                        return;
                    }

                    if (query === activeQuery) {
                        return;
                    }

                    activeQuery = query;
                    loadProducts(1);
                }, delay);
            }

            searchInput.addEventListener("input", function () {
                queueSearch(250);
            });

            if (searchForm) {
                searchForm.addEventListener("submit", function (event) {
                    event.preventDefault();
                    queueSearch(0);
                });
            }
        }

        grid.addEventListener("click", async function (event) {
            const button = event.target.closest(".add-btn");

            if (!button || !grid.contains(button) || !options.cartEnabled || button.disabled) {
                return;
            }

            const card = button.closest(".product-card");
            const productId = card ? Number(card.dataset.productId) : 0;

            if (!Number.isInteger(productId) || productId < 1) {
                return;
            }

            const original = button.textContent;
            button.disabled = true;
            button.textContent = "در حال افزودن...";

            try {
                await addToCart(productId, options);
                button.textContent = "✓ اضافه شد";
            } catch (error) {
                button.textContent = "دوباره تلاش کنید";
            }

            window.setTimeout(function () {
                button.textContent = original;
                button.disabled = false;
            }, 1200);
        });

        loadProducts(currentPage);
    }

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll("[data-product-listing]").forEach(initListing);
    });
}());
