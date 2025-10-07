// Mostrar / ocultar contraseña
const togglePassword = document.getElementById("togglePassword");
const passwordInput = document.getElementById("password");

togglePassword.addEventListener("click", () => {
  const type = passwordInput.type === "password" ? "text" : "password";
  passwordInput.type = type;

  togglePassword.textContent = type === "password" ? "👁️" : "🙈";
});

// Simulación de registro
document.querySelector(".signup-form").addEventListener("submit", (e) => {
  e.preventDefault();
  alert("Cuenta creada exitosamente 🚀");
});
