const price = () => {
    const priceInput = document.getElementById("item-price");
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (!priceInput || !addTaxDom || !profitDom) return;

    priceInput.addEventListener("input", () => {
        const inputValue = priceInput.value;

        if (!isNaN(inputValue) && inputValue !== "") {
            addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
            profitDom.innerHTML = Math.floor(inputValue * 0.9);
        } else {
            addTaxDom.innerHTML = "";
            profitDom.innerHTML = "";
        }
    });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
