document.addEventListener("DOMContentLoaded", function () {
  const button = document.getElementById("show-review-form-button");
  console.log("reply button ",button);
  const reviewFormContainer = document.getElementById("review-form-container");
  console.log("reviewFormContainer ",reviewFormContainer);

  button.addEventListener("click", function (event) {
    console.log("Button clicked");                
    event.preventDefault();
    reviewFormContainer.style.display =
      reviewFormContainer.style.display === "none" ? "block" : "none";
  });
});
