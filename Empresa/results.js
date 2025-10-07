document.addEventListener('DOMContentLoaded', () => {
  const resultsSubtitle = document.getElementById('results-subtitle');
  
  // Obtener los parámetros de la URL
  const params = new URLSearchParams(window.location.search);
  const puesto = params.get('puesto');
  const tipoLugar = params.get('tipoLugar');

  // Construir el subtítulo con los filtros aplicados
  let subtitleText = `Mostrando resultados para: <strong>${puesto || 'Todos los puestos'}</strong>`;
  if (tipoLugar) {
    subtitleText += ` (${tipoLugar})`;
  }

  resultsSubtitle.innerHTML = subtitleText;

  // En una aplicación real, aquí harías una llamada a una API para filtrar y mostrar los resultados.
});