(function () {
    "use strict";

    const unavailableText = "فعلا قابل خرید نیست";
    const loadingText = "در حال افزودن...";
    const successText = "✓ اضافه شد";
    const retryText = "دوباره تلاش کنید";

    function getProductId(button) {
        const rawValue = button.dataset.productId || "";
        const productId = Number(rawValue);

        return Number.isInteger(productId) && productId > 0 ? productId : null;
    }

    function markUnavailable(button) {
        button.type = "button";
        button.disabled = true;
        button.textContent = button.dataset.unavailableText || unavailableText;
        button.title = "این محصول هنوز به کالای قابل خرید در فروشگاه متصل نشده است.";
        button.setAttribute("aria-disabled", "true");
    }

    async function handleClick(button, productId) {
        if (!window.AlkamooneCommerce || typeof window.AlkamooneCommerce.addToCart !== "function") {
            button.textContent = retryText;
            return;
        }

        const original = button.dataset.buttonText || button.textContent;
        button.dataset.buttonText = original;
        button.disabled = true;
        button.textContent = loadingText;

        try {
            await window.AlkamooneCommerce.addToCart(productId, 1);
            button.textContent = successText;
        } catch (error) {
            button.textContent = retryText;
            button.title = error && error.message ? error.message : "";
        }

        window.setTimeout(function () {
            button.textContent = original;
            button.disabled = false;
        }, 1200);
    }

    function initButton(button) {
        if (button.dataset.staticCartReady === "true") {
            return;
        }

        button.dataset.staticCartReady = "true";

        const productId = getProductId(button);

        if (productId === null) {
            markUnavailable(button);
            return;
        }

        button.type = "button";
        button.addEventListener("click", function () {
            if (!button.disabled) {
                handleClick(button, productId);
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".add-btn").forEach(initButton);
    });
}());