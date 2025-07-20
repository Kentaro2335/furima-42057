// 読み込み確認用コメント
const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value);
    const inputValue = priceInput.value;

    if (isNaN(price) || price < 300 || price > 9999999) {
      addTaxDom.innerHTML = "";
      profitDom.innerHTML = "";
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = price - tax;

    addTaxDom.innerHTML = `${tax.toLocaleString()}`;
    profitDom.innerHTML = `${profit.toLocaleString()}`;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
