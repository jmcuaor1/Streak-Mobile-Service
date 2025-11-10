document.addEventListener('DOMContentLoaded', () => {
  const resendLink = document.getElementById('resend-link');
  const resendTimerSpan = document.getElementById('resend-timer');
  const toastContainer = document.getElementById('toast-container');
  
  let countdown;
  let secondsLeft = 60;

  // Función para mostrar notificaciones Toast
  const showToast = (message) => {
    // Limpia notificaciones anteriores
    toastContainer.innerHTML = '';

    const toast = document.createElement('div');
    toast.className = 'toast';
    // Usamos un ícono de Font Awesome si está disponible, si no, un emoji
    const iconHTML = typeof FontAwesome === 'object' ? '<i class="fas fa-check-circle toast-icon"></i>' : '✔️';
    toast.innerHTML = `${iconHTML} ${message}`;
    
    toastContainer.appendChild(toast);

    // Elimina el toast después de la animación
    setTimeout(() => {
      toast.remove();
    }, 3000);
  };

  // Función para iniciar el temporizador
  const startTimer = () => {
    resendLink.setAttribute('aria-disabled', 'true');
    secondsLeft = 60;
    resendTimerSpan.textContent = `(espera ${secondsLeft}s)`;

    countdown = setInterval(() => {
      secondsLeft--;
      resendTimerSpan.textContent = `(espera ${secondsLeft}s)`;
      if (secondsLeft <= 0) {
        clearInterval(countdown);
        resendTimerSpan.textContent = '';
        resendLink.removeAttribute('aria-disabled');
      }
    }, 1000);
  };

  // Evento de clic para reenviar
  resendLink.addEventListener('click', (e) => {
    e.preventDefault();
    if (resendLink.getAttribute('aria-disabled') === 'true') {
      return;
    }

    // Simula el reenvío del correo
    showToast('Correo reenviado exitosamente.');
    startTimer();
  });

  // Inicia el temporizador al cargar la página
  startTimer();
});