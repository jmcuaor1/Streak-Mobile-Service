document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('signup-form');
  const passwordInput = document.getElementById('password');
  const togglePassword = document.getElementById('togglePassword');
  
  // Elementos del medidor de contraseña
  const strengthMeter = document.getElementById('password-strength-meter');
  const strengthBar = document.getElementById('password-strength-bar');
  const strengthText = document.getElementById('password-strength-text');

  // --- Lógica para mostrar/ocultar contraseña ---
  togglePassword.addEventListener('click', () => {
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    
    // Cambiar el ícono del ojo
    togglePassword.classList.toggle('fa-eye');
    togglePassword.classList.toggle('fa-eye-slash');
  });

  // --- Lógica para el medidor de seguridad de la contraseña ---
  passwordInput.addEventListener('input', () => {
    const password = passwordInput.value;
    const strength = checkPasswordStrength(password);
    
    strengthMeter.style.display = password.length > 0 ? 'block' : 'none';

    let strengthValue = 0;
    let barColor = '';
    let text = '';

    if (strength.isStrong) {
      strengthValue = 100;
      barColor = 'var(--strength-strong)';
      text = 'Fuerte';
    } else if (strength.isMedium) {
      strengthValue = 66;
      barColor = 'var(--strength-medium)';
      text = 'Media';
    } else if (password.length > 0) {
      strengthValue = 33;
      barColor = 'var(--strength-weak)';
      text = 'Débil';
    }

    strengthBar.style.width = `${strengthValue}%`;
    strengthBar.style.backgroundColor = barColor;
    strengthText.textContent = text;
    strengthText.style.color = barColor;
  });

  const checkPasswordStrength = (password) => {
    const hasNumber = /\d/.test(password);
    const hasUpper = /[A-Z]/.test(password);
    const hasLower = /[a-z]/.test(password);
    const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    const isLongEnough = password.length >= 8;

    const score = [hasNumber, hasUpper, hasLower, hasSpecial, isLongEnough].filter(Boolean).length;

    return {
      isStrong: score >= 4,
      isMedium: score === 3,
    };
  };

  // --- Lógica de envío de formulario ---
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const password = passwordInput.value;

    if (name.trim() === '' || email.trim() === '' || password.trim() === '') {
      alert('Por favor, completa todos los campos.');
      return;
    }

    alert(`¡Bienvenido, ${name}! Tu cuenta ha sido creada exitosamente.`);
    form.reset();
    strengthMeter.style.display = 'none'; // Ocultar medidor al resetear
  });
});