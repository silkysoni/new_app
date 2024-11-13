document.addEventListener("DOMContentLoaded", function () {
  const updateCartSummary = () => {
    let totalQuantity = 0;
    let subtotal = 0;

    document.querySelectorAll(".card").forEach((card) => {
      const quantityElement = card.querySelector('[id^="quantity-"]');
      const priceElement = card.querySelector('[id^="total-price-"]');

      if (quantityElement && priceElement) {
        const quantity = parseInt(quantityElement.textContent) || 0;
        const price =
          parseFloat(priceElement.textContent.replace(/[$,]/g, "")) || 0;

        console.log("Qty: ", quantity);
        console.log("Price: ", price);

        subtotal += price;
        totalQuantity += quantity;
      } else {
        console.warn("Missing quantity or price element for card:", card);
      }
    });

    document.getElementById("subtotal-amount").textContent =
      new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
      }).format(subtotal);

    document.getElementById("total-quantity").textContent = totalQuantity;

    const modalSubtotal = document.getElementById("modal-subtotal-amount");
    if (modalSubtotal) {
      modalSubtotal.textContent = new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
      }).format(subtotal);
    }
  };

  if (window.location.pathname === "/carts.") {
    updateCartSummary();
  }
  // updateCartSummary();

  document.querySelectorAll(".btn-decrease").forEach((button) => {
    button.addEventListener("click", function () {
      const cartItemId = this.dataset.cartItemId;
      const price = this.dataset.price;
      console.log("cartItemId ", cartItemId);
      const quantityElement = document.getElementById(`quantity-${cartItemId}`);

      let quantity = parseInt(quantityElement.textContent) || 0;
      if (quantity > 1) {
        quantity--;
        quantityElement.textContent = quantity;
      }

      totalPrice = quantity * price;

      const priceElement = document.getElementById(`total-price-${cartItemId}`);
      priceElement.textContent = totalPrice;

      updateCartSummary();
    });
  });

  document.querySelectorAll(".btn-increase").forEach((button) => {
    console.log("button increase");
    button.addEventListener("click", function () {
      const cartItemId = this.dataset.cartItemId;
      const price = this.dataset.price;
      console.log("cartItemId ", cartItemId);
      const quantityElement = document.getElementById(`quantity-${cartItemId}`);
      console.log("quantityElement ", quantityElement);

      let quantity = parseInt(quantityElement.textContent) || 0;

      quantity++;
      quantityElement.textContent = quantity;

      totalPrice = quantity * price;

      const priceElement = document.getElementById(`total-price-${cartItemId}`);
      priceElement.textContent = totalPrice;

      updateCartSummary();
    });
  });

  const purchaseForm = document.getElementById("purchase-form");
  if (purchaseForm) {
    purchaseForm.addEventListener("submit", function (event) {
      const hiddenQuantities = document.getElementById("hidden-quantities");
      hiddenQuantities.innerHTML = ""; // Clear previous hidden inputs

      document.querySelectorAll(".card").forEach((card) => {
        const cartItemId = card
          .querySelector('[id^="quantity-"]')
          .id.split("-")[1]; // Get the ID

        console.log("cartItemId in purchase ", cartItemId);

        const quantityElement = document.getElementById(
          `quantity-${cartItemId}`
        );

        console.log("quantityElement in purchase ", quantityElement);

        const quantity =
          parseInt(card.querySelector('[id^="quantity-"]').textContent) || 0;

        const input = document.createElement("input");
        input.type = "hidden";
        input.name = `cart_items[${cartItemId}][quantity]`;
        input.value = quantity;
        hiddenQuantities.appendChild(input);
      });

      // const selectedAddress = document.querySelector(
      //   'input[name="selected_address"]:checked'
      // );
      // console.log("selectedAddress ", selectedAddress);
      // console.log("selectedAddress.value ", selectedAddress.value);
      // if (selectedAddress) {
      //   document.getElementById("selected_address_input").value =
      //     selectedAddress.value;
      // } else {
      //   alert("Please select an address before proceeding.");
      //   event.preventDefault();
      // }
    });
  } else {
    console.log("Purchase form not found!");
  }
});
