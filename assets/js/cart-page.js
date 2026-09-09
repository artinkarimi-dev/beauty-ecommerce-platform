(function () {
    "use strict";

    const commerce = window.AlkamooneCommerce;
    const state = {
        cart: null,
        busy: false
    };

    function qs(selector) {
        return document.querySelector(selector);
    }

    function setStatus(message, type) {
        const status = qs("[data-cart-status]");
        if (!status) {
            return;
        }

        status.textContent = message || "";
        status.dataset.status = type || "";
        status.hidden = !message;
    }

    function setCheckoutStatus(message, type) {
        const status = qs("[data-checkout-status]");
        if (!status) {
            return;
        }

        status.textContent = message || "";
        status.dataset.status = type || "";
        status.hidden = !message;
    }

    function renderCart(cart) {
        state.cart = cart;
        const list = qs("[data-cart-items]");
        const empty = qs("[data-cart-empty]");
        const summaryCount = qs("[data-cart-count]");
        const summaryTotal = qs("[data-cart-total]");
        const checkoutButton = qs("[data-submit-order]");

        if (!list || !empty) {
            return;
        }

        list.replaceChildren();
        const items = cart.items || [];
        const hasBlockedPrice = items.some(function (item) {
            return !item.product || item.product.price_amount === null;
        });

        empty.hidden = items.length !== 0;
        list.hidden = items.length === 0;

        items.forEach(function (item) {
            list.appendChild(createCartItem(item));
        });

        if (summaryCount) {
            summaryCount.textContent = String(cart.count || 0);
        }

        if (summaryTotal) {
            summaryTotal.textContent = commerce.safeText(cart.total_label, commerce.formatPrice(cart.total_amount));
        }

        if (checkoutButton) {
            checkoutButton.disabled = items.length === 0 || hasBlockedPrice || state.busy;
        }

        if (hasBlockedPrice) {
            setCheckoutStatus("یکی از محصولات نیاز به تایید قیمت دارد و قابل ثبت سفارش آنلاین نیست.", "error");
        }
    }

    function createCartItem(item) {
        const product = item.product || {};
        const productId = Number(product.id);
        const row = document.createElement("article");
        row.className = "cart-item";
        row.dataset.productId = String(productId);

        const image = document.createElement("div");
        image.className = "cart-item-image";
        appendImageContent(image, product);

        const details = document.createElement("div");
        details.className = "cart-item-details";

        const title = document.createElement("h3");
        title.textContent = commerce.safeText(product.name, "محصول");

        const meta = document.createElement("p");
        meta.textContent = commerce.safeText(product.category && product.category.name, "محصول فروشگاه");

        const price = document.createElement("strong");
        price.textContent = commerce.safeText(product.price_label, commerce.formatPrice(product.price_amount));

        details.append(title, meta, price);

        const controls = document.createElement("div");
        controls.className = "cart-item-controls";

        const decrease = document.createElement("button");
        decrease.type = "button";
        decrease.dataset.cartAction = "decrease";
        decrease.textContent = "-";
        decrease.setAttribute("aria-label", "کاهش تعداد");

        const quantity = document.createElement("span");
        quantity.className = "quantity";
        quantity.textContent = String(item.quantity || 0);

        const increase = document.createElement("button");
        increase.type = "button";
        increase.dataset.cartAction = "increase";
        increase.textContent = "+";
        increase.setAttribute("aria-label", "افزایش تعداد");

        const remove = document.createElement("button");
        remove.type = "button";
        remove.className = "remove";
        remove.dataset.cartAction = "remove";
        remove.textContent = "حذف";

        const total = document.createElement("span");
        total.className = "line-total";
        total.textContent = commerce.safeText(item.line_total_label, commerce.formatPrice(item.line_total));

        controls.append(decrease, quantity, increase, remove, total);
        row.append(image, details, controls);

        return row;
    }

    function appendImageContent(box, product) {
        const imageValue = commerce.safeText(product.image, "○");

        if (!isSafeImagePath(imageValue)) {
            box.textContent = imageValue;
            return;
        }

        const image = document.createElement("img");
        image.src = imageValue;
        image.alt = commerce.safeText(product.name, "");
        image.loading = "lazy";
        image.decoding = "async";
        image.addEventListener("error", function () {
            box.textContent = commerce.safeText(product.name, "محصول");
        }, { once: true });
        box.appendChild(image);
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

    async function loadCart(message) {
        setStatus(message || "در حال دریافت سبد خرید...", "loading");

        try {
            renderCart(await commerce.getCart());
            setStatus("", "");
        } catch (error) {
            setStatus(error.message || "سبد خرید در دسترس نیست.", "error");
        }
    }

    async function handleCartClick(event) {
        const button = event.target.closest("[data-cart-action]");
        if (!button || state.busy) {
            return;
        }

        const row = button.closest(".cart-item");
        const productId = row ? Number(row.dataset.productId) : 0;
        const item = state.cart && state.cart.items
            ? state.cart.items.find(function (entry) {
                return entry.product && Number(entry.product.id) === productId;
            })
            : null;

        if (!productId || !item) {
            return;
        }

        state.busy = true;
        renderCart(state.cart);
        setStatus("در حال به‌روزرسانی سبد خرید...", "loading");

        try {
            if (button.dataset.cartAction === "remove") {
                renderCart(await commerce.removeCartItem(productId));
            } else {
                const nextQuantity = button.dataset.cartAction === "increase"
                    ? Number(item.quantity) + 1
                    : Number(item.quantity) - 1;

                if (nextQuantity < 1) {
                    renderCart(await commerce.removeCartItem(productId));
                } else {
                    renderCart(await commerce.updateCartItem(productId, nextQuantity));
                }
            }

            setStatus("", "");
        } catch (error) {
            const message = error.message || "سبد خرید به‌روزرسانی نشد.";
            await loadCart("");
            setStatus(message, "error");
        } finally {
            state.busy = false;
            renderCart(state.cart || { items: [], count: 0, total_label: commerce.formatPrice(0) });
        }
    }

    async function handleCheckout(event) {
        event.preventDefault();

        if (state.busy) {
            return;
        }

        const form = event.currentTarget;
        const customer = {
            name: form.elements.name.value.trim(),
            phone: form.elements.phone.value.trim(),
            address: form.elements.address.value.trim(),
            note: form.elements.note.value.trim()
        };

        if (customer.name.length < 2 || customer.phone.length < 10 || customer.address.length < 10) {
            setCheckoutStatus("نام، شماره تماس و آدرس را کامل وارد کنید.", "error");
            return;
        }

        state.busy = true;
        setCheckoutStatus("در حال ثبت سفارش...", "loading");

        try {
            const data = await commerce.createOrder(customer);
            const order = data.order || {};
            const success = qs("[data-order-success]");
            const tracking = qs("[data-success-tracking]");

            if (tracking) {
                tracking.textContent = commerce.safeText(order.tracking_code, "");
            }

            if (success) {
                success.hidden = false;
            }

            form.reset();
            setCheckoutStatus("سفارش با موفقیت ثبت شد.", "success");
            await loadCart("");
        } catch (error) {
            setCheckoutStatus(error.message || "سفارش ثبت نشد.", "error");
            await loadCart("");
        } finally {
            state.busy = false;
            renderCart(state.cart || { items: [], count: 0, total_label: commerce.formatPrice(0) });
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        const list = qs("[data-cart-items]");
        const form = qs("[data-checkout-form]");

        if (list) {
            list.addEventListener("click", handleCartClick);
        }

        if (form) {
            form.addEventListener("submit", handleCheckout);
        }

        loadCart();
    });
}());
