(function () {
    "use strict";

    const apiBase = new URL("../../api/", document.currentScript ? document.currentScript.src : window.location.href);
    const endpoints = {
        session: new URL("session.php", apiBase).href,
        cart: new URL("cart.php", apiBase).href,
        orders: new URL("orders.php", apiBase).href
    };
    let csrfToken = null;
    let csrfRequest = null;

    function formatPrice(amount) {
        if (amount === null || amount === undefined || amount === "") {
            return "تماس بگیرید";
        }

        return new Intl.NumberFormat("fa-IR").format(Number(amount)) + " تومان";
    }

    function safeText(value, fallback) {
        return value === null || value === undefined || value === "" ? fallback : String(value);
    }

    async function parsePayload(response) {
        let payload = null;

        try {
            payload = await response.json();
        } catch (error) {
            throw new Error("پاسخ سرور قابل خواندن نیست.");
        }

        if (!response.ok || !payload || payload.success !== true) {
            const code = payload && payload.error ? payload.error.code : "SERVER_ERROR";
            const error = new Error(messageForCode(code));
            error.code = code;
            error.status = response.status;
            throw error;
        }

        if (payload.data && payload.data.csrf_token) {
            csrfToken = payload.data.csrf_token;
        }

        return payload.data || {};
    }

    function messageForCode(code) {
        const messages = {
            CSRF_FAILED: "نشست شما منقضی شده است. دوباره تلاش کنید.",
            VALIDATION_ERROR: "اطلاعات وارد شده را بررسی کنید.",
            EMPTY_CART: "سبد خرید خالی است.",
            INSUFFICIENT_STOCK: "موجودی یکی از محصولات کافی نیست.",
            PRICE_UNAVAILABLE: "قیمت یکی از محصولات نیاز به تایید دارد.",
            PRODUCT_UNAVAILABLE: "یکی از محصولات دیگر در دسترس نیست.",
            NOT_FOUND: "موردی با این اطلاعات پیدا نشد.",
            INVALID_JSON: "پاسخ سرور معتبر نیست.",
            SERVER_ERROR: "در حال حاضر امکان انجام درخواست وجود ندارد."
        };

        return messages[code] || messages.SERVER_ERROR;
    }

    async function getCsrfToken(forceRefresh) {
        if (csrfToken && !forceRefresh) {
            return csrfToken;
        }

        if (csrfRequest && !forceRefresh) {
            return csrfRequest;
        }

        csrfRequest = fetch(endpoints.session, {
            headers: {
                Accept: "application/json"
            },
            credentials: "same-origin"
        })
            .then(parsePayload)
            .then(function (data) {
                if (!data.csrf_token) {
                    throw new Error("نشست فروشگاه آماده نیست.");
                }

                csrfToken = data.csrf_token;
                return csrfToken;
            })
            .finally(function () {
                csrfRequest = null;
            });

        return csrfRequest;
    }

    async function requestJson(url, options, retryOnCsrf) {
        const response = await fetch(url, options);

        if (response.status === 403 && retryOnCsrf) {
            csrfToken = null;
            const token = await getCsrfToken(true);
            const headers = new Headers(options.headers || {});
            headers.set("X-CSRF-Token", token);

            return requestJson(url, Object.assign({}, options, { headers }), false);
        }

        return parsePayload(response);
    }

    async function getCart() {
        return requestJson(endpoints.cart, {
            headers: {
                Accept: "application/json"
            },
            credentials: "same-origin"
        }, false);
    }

    async function mutateCart(method, body) {
        const token = await getCsrfToken(false);

        return requestJson(endpoints.cart, {
            method,
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json",
                "X-CSRF-Token": token
            },
            credentials: "same-origin",
            body: JSON.stringify(body)
        }, true);
    }

    async function updateCartItem(productId, quantity) {
        return mutateCart("PATCH", {
            product_id: productId,
            quantity
        });
    }

    async function removeCartItem(productId) {
        return mutateCart("DELETE", {
            product_id: productId
        });
    }

    async function createOrder(customer) {
        const token = await getCsrfToken(false);

        return requestJson(endpoints.orders, {
            method: "POST",
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json",
                "X-CSRF-Token": token
            },
            credentials: "same-origin",
            body: JSON.stringify(customer)
        }, true);
    }

    async function trackOrder(trackingCode, phone) {
        const url = new URL(endpoints.orders);
        url.searchParams.set("tracking_code", trackingCode);
        url.searchParams.set("phone", phone);

        return requestJson(url.href, {
            headers: {
                Accept: "application/json"
            },
            credentials: "same-origin"
        }, false);
    }

    window.AlkamooneCommerce = {
        formatPrice,
        safeText,
        messageForCode,
        getCart,
        updateCartItem,
        removeCartItem,
        createOrder,
        trackOrder
    };
}());
