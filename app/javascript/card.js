const pay = () => {
  const payjp = Payjp('pk_test_ad3c44dc66fef70952944a0a'); 
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        return;
      } else {
        const token = response.id;
        const tokenObj = document.createElement("input");
        tokenObj.setAttribute("type", "hidden");
        tokenObj.setAttribute("name", "token");
        tokenObj.setAttribute("value", token);
        form.appendChild(tokenObj);

        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);
