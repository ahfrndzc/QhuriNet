console.log("mapainteractivo.js cargado correctamente");

const contenedorMapa = document.getElementById("mapa-interactivo");

if (!contenedorMapa) {
  console.error("ERROR: No se encontró el contenedor con id 'mapa-interactivo'");
} else {

  const map = L.map("mapa-interactivo", {
    attributionControl: false
  }).setView([-12.0464, -77.0428], 13);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19
  }).addTo(map);

  const tarjetaRuta    = document.getElementById("ruta-floating");
  const rutaDistanciaEl = document.getElementById("ruta-distancia");
  const rutaTiempoEl    = document.getElementById("ruta-tiempo");
  const rutaOrdenEl     = document.getElementById("ruta-orden");
  const botonReset      = document.getElementById("ruta-reset");

  tarjetaRuta.classList.add("oculto");

  const capaAcopio     = L.layerGroup().addTo(map);
  const capaBodega     = L.layerGroup().addTo(map);
  const capaReciclador = L.layerGroup().addTo(map);
  const capaMunicipal  = L.layerGroup().addTo(map);

  const iconAcopio = L.divIcon({
    html: `
      <div class="marker marker-acopio">
        <span style="font-size:20px;">♻</span>
      </div>
    `,
    className: "",
    iconSize: [40, 40],
  });

  const iconBodega = L.divIcon({
    html: `
      <div class="marker marker-bodega">
        <svg viewBox="0 0 24 24">
          <path d="M4 10L12 4L20 10" fill="white"/>
          <rect x="6" y="10" width="12" height="8" rx="1" fill="white"/>
          <rect x="7" y="11" width="3" height="3" fill="#C0A24A"/>
          <rect x="14" y="11" width="3" height="3" fill="#C0A24A"/>
        </svg>
      </div>
    `,
    className: "",
    iconSize: [40, 40],
  });

  const iconReciclador = L.divIcon({
    html: `
      <div class="marker marker-reciclador">
        <svg viewBox="0 0 24 24">
          <!-- cabina -->
          <rect x="5" y="11" width="7" height="4" rx="1" fill="white"/>
          <!-- caja -->
          <rect x="12" y="10" width="7" height="5" rx="1" fill="white"/>
          <!-- ventana -->
          <rect x="6.2" y="12" width="2" height="2" fill="#E46D6A"/>
          <!-- ruedas -->
          <circle cx="8"  cy="17" r="1.4" fill="#E46D6A"/>
          <circle cx="16" cy="17" r="1.4" fill="#E46D6A"/>
        </svg>
      </div>
    `,
    className: "",
    iconSize: [40, 40],
  });

  const iconMunicipal = L.divIcon({
    html: `
      <div class="marker marker-municipal">
        <svg viewBox="0 0 24 24">
          <rect x="7" y="7" width="10" height="10" fill="white"/>
          <rect x="11" y="13" width="2" height="4" fill="#51738D"/>
          <rect x="8.5" y="8.5" width="1.6" height="1.6" fill="#51738D"/>
          <rect x="11.2" y="8.5" width="1.6" height="1.6" fill="#51738D"/>
          <rect x="13.9" y="8.5" width="1.6" height="1.6" fill="#51738D"/>
        </svg>
      </div>
    `,
    className: "",
    iconSize: [40, 40],
  });

  const iconUbicacion = L.divIcon({
    html: `
      <div class="marker marker-ubicacion"></div>
    `,
    className: "",
    iconSize: [32, 32],
  });

  const markerAcopio = L.marker([-12.06, -77.03], { icon: iconAcopio })
    .addTo(capaAcopio)
    .bindPopup("Centro de Acopio");
  markerAcopio.meta = { nombre: "Centro de Acopio" };

  const markerBodega = L.marker([-12.0464, -77.0428], { icon: iconBodega })
    .addTo(capaBodega)
    .bindPopup("Comercio/Bodega");
  markerBodega.meta = { nombre: "Comercio/Bodega" };

  const markerReciclador = L.marker([-12.07, -77.05], { icon: iconReciclador })
    .addTo(capaReciclador)
    .bindPopup("Reciclador");
  markerReciclador.meta = { nombre: "Reciclador" };

  const markerMunicipal = L.marker([-12.09, -77.04], { icon: iconMunicipal })
    .addTo(capaMunicipal)
    .bindPopup("Punto Municipal");
  markerMunicipal.meta = { nombre: "Punto Municipal" };

  // Ubicación simulada
  const ubicacionLatLng = { lat: -12.055, lng: -77.04 };
  const markerUbicacion = L.marker(
    [ubicacionLatLng.lat, ubicacionLatLng.lng],
    { icon: iconUbicacion }
  ).addTo(map);

  let puntosSeleccionados = [];   
  let rutaLayer = null;

  function limpiarRuta() {
    puntosSeleccionados = [];

    if (rutaLayer) {
      map.removeLayer(rutaLayer);
      rutaLayer = null;
    }

    rutaDistanciaEl.textContent = "Distancia total: --";
    rutaTiempoEl.textContent    = "Tiempo estimado: --";
    rutaOrdenEl.innerHTML       = "";
    tarjetaRuta.classList.add("oculto");
  }

  async function calcularRutaOSRM() {
    if (puntosSeleccionados.length === 0) return;

    const start = ubicacionLatLng;


    let coords = `${start.lng},${start.lat}`;
    for (const p of puntosSeleccionados) {
      coords += `;${p.lng},${p.lat}`;
    }

    const url =
      `https://router.project-osrm.org/route/v1/driving/` +
      coords +
      `?overview=full&geometries=geojson`;

    try {
      const resp = await fetch(url);
      const data = await resp.json();

      if (!data.routes || !data.routes.length) {
        console.error("OSRM sin rutas válidas", data);
        return;
      }

      const route = data.routes[0];

      const distanciaKm = route.distance / 1000;
      const tiempoMin   = route.duration / 60;

      rutaDistanciaEl.textContent =
        `Distancia total: ${distanciaKm.toFixed(1)} km`;
      rutaTiempoEl.textContent =
        `Tiempo estimado: ${Math.round(tiempoMin)} min`;

      rutaOrdenEl.innerHTML = "";
      const li0 = document.createElement("li");
      li0.textContent = "Tu ubicación (simulada)";
      rutaOrdenEl.appendChild(li0);

      puntosSeleccionados.forEach(p => {
        const li = document.createElement("li");
        li.textContent = p.nombre;
        rutaOrdenEl.appendChild(li);
      });

      if (rutaLayer) map.removeLayer(rutaLayer);

      rutaLayer = L.geoJSON(route.geometry, {
        style: {
          color: "#4a8f46",
          weight: 4,
          opacity: 0.9
        }
      }).addTo(map);

      map.fitBounds(rutaLayer.getBounds(), { padding: [30, 30] });
      tarjetaRuta.classList.remove("oculto");

    } catch (err) {
      console.error("Error al llamar a OSRM", err);
    }
  }

  function onMarkerClick(e) {
    const marker = e.target;
    const { lat, lng } = marker.getLatLng();
    const nombre = marker.meta?.nombre || "Punto";

    puntosSeleccionados.push({ lat, lng, nombre });
    calcularRutaOSRM();
  }

  markerAcopio.on("click", onMarkerClick);
  markerBodega.on("click", onMarkerClick);
  markerReciclador.on("click", onMarkerClick);
  markerMunicipal.on("click", onMarkerClick);

  botonReset.addEventListener("click", () => {
    limpiarRuta();
    map.setView([-12.0464, -77.0428], 13);
  });

  const fA = document.getElementById("filtro-acopio");
  const fB = document.getElementById("filtro-bodega");
  const fR = document.getElementById("filtro-reciclador");
  const fM = document.getElementById("filtro-municipal");

  function actualizarCapas() {
    const a = fA.checked;
    const b = fB.checked;
    const r = fR.checked;
    const m = fM.checked;

    const ninguno = !a && !b && !r && !m;

    if (ninguno) {
      map.addLayer(capaAcopio);
      map.addLayer(capaBodega);
      map.addLayer(capaReciclador);
      map.addLayer(capaMunicipal);
      return;
    }

    a ? map.addLayer(capaAcopio)     : map.removeLayer(capaAcopio);
    b ? map.addLayer(capaBodega)     : map.removeLayer(capaBodega);
    r ? map.addLayer(capaReciclador) : map.removeLayer(capaReciclador);
    m ? map.addLayer(capaMunicipal)  : map.removeLayer(capaMunicipal);
  }

  fA.addEventListener("change", actualizarCapas);
  fB.addEventListener("change", actualizarCapas);
  fR.addEventListener("change", actualizarCapas);
  fM.addEventListener("change", actualizarCapas);

  actualizarCapas();

  setTimeout(() => map.invalidateSize(), 300);
}
