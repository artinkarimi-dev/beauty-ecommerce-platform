(function () {
    "use strict";

    const commerce = window.AlkamooneCommerce;

    function qs(selector) {
        return document.querySelector(selector);
    }

    function setStatus(message, type) {
        const status = qs("[data-tracking-status]");
        if (!status) {
            return;
        }

        status.textContent = message || "";
        status.dataset.status = type || "";
        status.hidden = !message;
        status.setAttribute("role", type === "error" ? "alert" : "status");
        status.setAttribute("aria-live", type === "error" ? "assertive" : "polite");
    }

    function renderOrder(order) {
        const result = qs("[data-tracking-result]");
        const items = qs("[data-tracking-items]");

        if (!result || !items) {
            return;
        }

        result.hidden = false;
        qs("[data-tracking-code]").textContent = commerce.safeText(order.tracking_code, "");
        qs("[data-tracking-name]").textContent = commerce.safeText(order.customer_name, "");
        qs("[data-tracking-state]").textContent = commerce.safeText(order.status, "");
        qs("[data-tracking-total]").textContent = commerce.safeText(order.total_label, commerce.formatPrice(order.total_amount));
        items.replaceChildren();

        (order.items || []).forEach(function (item) {
            const row = document.createElement("li");
            row.textContent = commerce.safeText(item.product_name, "محصول")
                + " × "
                + String(item.quantity || 0)
                + " - "
                + commerce.formatPrice(item.line_total);
            items.appendChild(row);
        });
    }

    async function handleSubmit(event) {
        event.preventDefault();

        const form = event.currentTarget;
        const result = qs("[data-tracking-result]");
        const trackingCode = form.elements.tracking_code.value.trim();
        const phone = form.elements.phone.value.trim();

        if (result) {
            result.hidden = true;
        }

        if (trackingCode.length !== 10 || phone.length < 10) {
            setStatus("کد رهگیری و شماره تماس را کامل وارد کنید.", "error");
            return;
        }

        setStatus("در حال دریافت وضعیت سفارش...", "loading");

        try {
            const data = await commerce.trackOrder(trackingCode, phone);
            renderOrder(data.order || {});
            setStatus("", "");
        } catch (error) {
            setStatus(error.message || "سفارشی با این اطلاعات پیدا نشد.", "error");
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        const form = qs("[data-tracking-form]");

        if (form) {
            form.addEventListener("submit", handleSubmit);
        }
    });
}());
