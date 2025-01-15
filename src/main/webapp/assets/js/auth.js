const container = document.getElementById("container");
const registerBtn = document.getElementById("register");
const loginBtn = document.getElementById("login");
const forgotPWLink = document.querySelector(".sign-in a");
const resetPasswordForm = document.querySelector(".reset-password");
const signInForm = document.querySelector(".sign-in");
const signUpForm = document.querySelector(".sign-up");

registerBtn.addEventListener("click", () => {
    signUpForm.style.display = "block";
    signInForm.style.display = "none";
    container.classList.add("active");
});

loginBtn.addEventListener("click", () => {
    signInForm.style.display = "block";
    signUpForm.style.display = "none";
    container.classList.remove("active");
});

forgotPWLink.addEventListener("click", (e) => {
    container.classList.add("active");

    signUpForm.style.display = "none";
    signInForm.style.display = "none";
    resetPasswordForm.style.display = "block";
});
