document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('forgot-form');
  const emailInput = document.getElementById('email');

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const email = emailInput.value;

    if (email.trim() === '' || !email.includes('@')) {
      alert('Por favor, introduce una dirección de correo electrónico válida.');
      return;
    }

    // Simulación de envío y redirección
    alert(`Se ha enviado un enlace de recuperación a ${email}.`);

    // Redirigir a la página de "Check" después de un breve retraso
    setTimeout(() => {
      window.location.href = '../Check/Index.html';
    }, 500);
  });
});