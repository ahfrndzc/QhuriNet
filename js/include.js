async function include(selector, file) {
  const element = document.querySelector(selector);
  if (!element) return;
  try {
    const response = await fetch(file);
    const html = await response.text();
    element.innerHTML = html;
  } catch (err) {
    console.error(`Error al cargar ${file}:`, err);
  }
}

include("#slot-header", "header.html");
include("#slot-footer", "footer.html");