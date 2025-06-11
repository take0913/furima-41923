const pay = () => {
    const form = document.getElementById("charge-form");
    if (!form) return;

    // ① 公開鍵を<meta>から取得
    const publicKey = document.querySelector(
        'meta[name="payjp-public-key"]'
    ).content;

    // ② Payjp インスタンスを生成
    const payjp = Payjp(publicKey);
    const elements = payjp.elements();

    // ③ カード番号・有効期限・CVC の要素をそれぞれ作る
    const numberElement = elements.create("cardNumber");
    const expiryElement = elements.create("cardExpiry");
    const cvcElement = elements.create("cardCvc");

    // ④ HTML上の対応する<div>にマウント
    numberElement.mount("#card-number");
    expiryElement.mount("#card-exp");
    cvcElement.mount("#card-cvc");

    // ⑤ フォーム送信時にトークン生成→hidden inputで追加→submit
    form.addEventListener("submit", async (e) => {
        e.preventDefault();
        const response = await payjp.createToken(numberElement);
        if (response.error) {
            alert(response.error.message);
        } else {
            const tokenInput = document.createElement("input");
            tokenInput.setAttribute("type", "hidden");
            tokenInput.setAttribute("name", "token");
            tokenInput.setAttribute("value", response.id);
            form.appendChild(tokenInput);

            // マウントした要素をクリアして送信
            numberElement.clear();
            expiryElement.clear();
            cvcElement.clear();
            form.submit();
        }
    });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
