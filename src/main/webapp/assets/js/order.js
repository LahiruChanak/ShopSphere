document.querySelectorAll(".phone-number-group input").forEach((input) => {
    input.addEventListener("focus", () => {
        input.closest(".phone-number-group").classList.add("focused");
    });

    input.addEventListener("blur", () => {
        input.closest(".phone-number-group").classList.remove("focused");
    });
});