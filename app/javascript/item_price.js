window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = inputValue * 0.1

      const salesProfit = document.getElementById("profit");
        const valueResult = inputValue * 0.1
        salesProfit.innerHTML =  inputValue - valueResult
  })
});