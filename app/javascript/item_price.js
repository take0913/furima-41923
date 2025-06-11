const price = () => {
    const priceInput = document.getElementById("item-price");
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (!priceInput || !addTaxDom || !profitDom) return;

    priceInput.addEventListener("input", () => {
        const inputValue = priceInput.value;

        if (!isNaN(inputValue) && inputValue !== "") {
            const priceValue = Number(inputValue);
            const tax = Math.floor(priceValue * 0.1);
            const profit = priceValue - tax;
            addTaxDom.innerHTML = tax;
            profitDom.innerHTML = profit;
        } else {
            addTaxDom.innerHTML = "";
            profitDom.innerHTML = "";
        }
    });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
