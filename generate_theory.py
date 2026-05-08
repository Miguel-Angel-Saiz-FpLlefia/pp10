import re

# 50 topics about Shopify
topics = [
    ("intro-ecommerce", "Introducción al E-commerce y Shopify", "Qué es Shopify, cómo funciona el modelo SaaS vs Open Source y ventajas competitivas."),
    ("arquitectura-shopify", "Arquitectura de Shopify", "Estructura general, tiendas, bases de datos subyacentes, CDNs y la red global."),
    ("planes-precios", "Planes y Precios de Shopify", "Basic, Shopify, Advanced y Plus. Cuándo elegir cada uno y cómo calcular las comisiones de transacción."),
    ("configuracion-inicial", "Configuración Inicial de la Tienda", "Monedas, husos horarios, formatos de pedido y métricas base en el admin."),
    ("gestion-dominios", "Gestión de Dominios", "Conexión de dominios de terceros, dominios administrados por Shopify y certificados SSL automáticos."),
    ("productos-variantes", "Productos y Variantes", "Creación de productos, límite de 100 variantes, opciones (talla, color) y SKUs."),
    ("colecciones-manuales", "Colecciones Manuales", "Agrupación de productos seleccionados a mano. Casos de uso y ordenación personalizada."),
    ("colecciones-automatizadas", "Colecciones Automatizadas", "Condiciones lógicas (etiquetas, precio, vendor) para auto-poblar colecciones. Ahorro de tiempo masivo."),
    ("inventario-ubicaciones", "Inventario y Ubicaciones", "Seguimiento de stock, múltiples almacenes (Locations) y lógica de fulfillment."),
    ("etiquetas-tags", "Sistema de Etiquetas (Tags)", "Uso de tags en productos, pedidos y clientes para segmentación y automatización."),
    ("metafields-intro", "Introducción a los Metafields", "Extensión del modelo de datos. Cómo añadir campos personalizados (fecha de caducidad, guía de tallas)."),
    ("metaobjects-intro", "Metaobjects: Tablas Personalizadas", "Creación de estructuras de datos complejas (ej. Perfiles de diseñadores) y páginas dinámicas."),
    ("clientes-segmentacion", "Gestión y Segmentación de Clientes", "Fichas de clientes, historial de pedidos, tags de clientes y filtros avanzados."),
    ("b2b-shopify", "B2B en Shopify", "Catálogos específicos por empresa, términos de pago (Net 30) y roles de usuario (solo en Plus)."),
    ("canales-venta", "Canales de Venta (Sales Channels)", "Vender en Facebook, Instagram, Google, Pinterest y el botón de compra integrado."),
    ("shopify-pos", "Shopify POS (Punto de Venta)", "Integración del inventario online con la tienda física. Hardware POS y sincronización."),
    ("pedidos-fulfillment", "Gestión de Pedidos y Fulfillment", "Ciclo de vida de un pedido: unfulfilled, fulfilled, archived. Captura manual vs automática."),
    ("devoluciones-reembolsos", "Devoluciones y Reembolsos", "Flujo de trabajo para procesar devoluciones, restaurar inventario y emitir notas de crédito."),
    ("shopify-markets", "Shopify Markets (Internacionalización)", "Vender globalmente: monedas locales, dominios internacionales, idiomas y catálogos por mercado."),
    ("impuestos-taxes", "Configuración de Impuestos", "Reglas impositivas por país, overrides fiscales y productos exentos de impuestos."),
    ("envios-zonas", "Perfiles y Zonas de Envío", "Tarifas basadas en peso vs precio. Zonas geográficas y envío gratuito condicional."),
    ("pasarelas-pago", "Shopify Payments y Pasarelas", "La pasarela nativa, comisiones adicionales por usar pasarelas externas (PayPal, MercadoPago)."),
    ("checkout-configuracion", "Configuración del Checkout", "Campos obligatorios, propinas, recogida en tienda y personalización visual básica."),
    ("checkout-extensibility", "Checkout Extensibility (Plus)", "Inyección de componentes React en el checkout mediante App Blocks (exclusivo para Plus)."),
    ("descuentos-cupones", "Descuentos y Códigos Promocionales", "Descuentos fijos, porcentajes, 2x1 (BOGO) y envío gratis."),
    ("descuentos-automaticos", "Descuentos Automáticos", "Descuentos que se aplican solos en el carrito sin necesidad de introducir un código."),
    ("tarjetas-regalo", "Tarjetas de Regalo (Gift Cards)", "Emisión, venta y redención de gift cards. Diferencia con los códigos de descuento."),
    ("marketing-basico", "Herramientas de Marketing Integradas", "Campañas de email nativas, automatizaciones de carritos abandonados y reportes básicos."),
    ("seo-basico", "SEO Básico en Shopify", "Sitemap automático, robots.txt, metadatos, textos alt y estructura de URLs forzada (/products/)."),
    ("redirecciones-301", "Redirecciones de URL (301)", "Importancia para migraciones. Cómo redirigir tráfico de enlaces muertos para preservar el SEO."),
    ("analitica-reportes", "Analítica y Reportes", "Panel de control, ventas por canal, sesiones y la importancia de la tasa de conversión."),
    ("liquid-sintaxis", "Liquid: Sintaxis Básica", "El lenguaje de plantillas. Output {{ }}, Tags {% %} y Filters |."),
    ("liquid-filtros", "Liquid: Filtros Avanzados", "Manipulación de strings, arrays, números (money) y formatos de fecha en Liquid."),
    ("liquid-bucles", "Liquid: Iteración y Bucles", "Uso de for, paginate, tablerow y límites para recorrer colecciones o artículos del carrito."),
    ("os2-arquitectura", "Online Store 2.0: Arquitectura", "La transición de plantillas .liquid a .json. Secciones en todas partes."),
    ("os2-secciones", "Desarrollo de Secciones (Sections)", "Bloque schema en JSON, settings, blocks y presets para que el comerciante edite visualmente."),
    ("os2-app-blocks", "App Blocks y Theme App Extensions", "Cómo las apps modernas inyectan código sin modificar archivos del tema, manteniendo la limpieza."),
    ("shopify-cli", "Shopify CLI y Entorno de Desarrollo", "Autenticación, theme dev, sincronización con la nube y despliegue automatizado."),
    ("github-integration", "Integración con GitHub", "Control de versiones nativo para temas. Ramas conectadas directamente a entornos de Shopify."),
    ("hydrogen-oxygen", "Hydrogen y Oxygen (Headless)", "Framework de React (Remix) para construir el frontend separado del backend. Hosting global Oxygen."),
    ("storefront-api", "Storefront API (GraphQL)", "La API para interactuar con productos y checkouts desde cualquier cliente web, móvil o videojuego."),
    ("admin-api-rest", "Admin API (REST vs GraphQL)", "Control total del backend. Rate limits, webhooks y diferencias de eficiencia entre REST y GraphQL."),
    ("webhooks-eventos", "Webhooks y Eventos", "Notificaciones push del servidor. Validación HMAC SHA256 y casos de uso (ej. sincronizar ERP)."),
    ("custom-apps", "Creación de Custom Apps", "Aplicaciones a medida para una sola tienda. Generación de tokens y permisos de acceso."),
    ("public-apps", "Public Apps y App Store", "Proceso para publicar apps SaaS. OAuth, facturación (Billing API) y revisión técnica."),
    ("shopify-flow", "Shopify Flow (Automatizaciones)", "Creador visual de flujos lógicos (Trigger -> Condition -> Action). Ej: Ocultar producto si stock es 0."),
    ("shopify-functions", "Shopify Functions (Rust/WASM)", "Reemplazo de los Shopify Scripts. Inyección de lógica en el backend (descuentos, enrutamiento de pedidos)."),
    ("pixels-tracking", "Web Pixel Manager y Tracking", "Seguimiento aislado en Sandbox. Eventos estándar (view_item, add_to_cart) y privacidad del usuario."),
    ("optimizacion-rendimiento", "Optimización de Rendimiento", "Imágenes WebP (image_url), preloading, eliminación de apps bloqueantes y Core Web Vitals."),
    ("seguridad-fraude", "Seguridad y Análisis de Fraude", "Filtros de Shopify, indicadores de riesgo en pedidos y protección de contraseñas de escaparate.")
]

html_template = """
<div class="space-y-6 text-gray-700 leading-relaxed">
    <p class="text-lg"><strong>{title}</strong> es un concepto fundamental en el desarrollo y administración de tiendas en Shopify.</p>
    
    <div class="bg-indigo-50 p-6 rounded-lg border-l-4 border-indigo-500 my-6 shadow-sm">
        <h3 class="text-xl font-bold text-indigo-800 mb-3">Concepto Principal</h3>
        <p class="text-indigo-900">{description}</p>
    </div>

    <h2 class="text-2xl font-bold text-gray-800 mt-8 mb-4 border-b pb-2">Implementación Técnica</h2>
    <p>Para dominar este aspecto, debes comprender cómo Shopify gestiona los datos en el backend y cómo se exponen en el frontend mediante Liquid o las APIs (Admin y Storefront).</p>
    
    <ul class="list-disc pl-5 space-y-3 mt-4">
        <li><strong>Fase 1 (Administración):</strong> Todo se configura primero en el panel de control de Shopify.</li>
        <li><strong>Fase 2 (Desarrollo):</strong> Usamos herramientas como Shopify CLI, Liquid, o llamadas a la API de GraphQL para conectar estos datos con la experiencia del usuario.</li>
        <li><strong>Fase 3 (Optimización):</strong> Monitorización del rendimiento y validación de permisos de seguridad.</li>
    </ul>

    <h2 class="text-2xl font-bold text-gray-800 mt-8 mb-4 border-b pb-2">Ejemplo Práctico</h2>
    <p>Imagina que estás construyendo una tienda desde cero. Al enfrentarte a este concepto, tu primer paso será:</p>
    <pre class="bg-gray-900 text-green-400 p-4 rounded-md overflow-x-auto text-sm mt-4 shadow-inner"><code>
<!-- Ejemplo genérico de código asociado a {title} -->
{{% if concept == '{slug}' %}}
  <h1>Dominando {title}</h1>
  <p>Status: Operativo y optimizado.</p>
{{% endif %}}
    </code></pre>

    <div class="bg-gray-100 p-5 rounded-lg border border-gray-200 mt-8">
        <h4 class="font-bold text-gray-800">Mejores Prácticas del Sector:</h4>
        <p class="text-sm text-gray-600 mt-2">Nunca modifiques código directamente en el tema en producción. Utiliza entornos locales, git, y ramas de GitHub integradas en Shopify para previsualizar los cambios de este módulo antes de publicarlos a tus clientes.</p>
    </div>
</div>
"""

inserts = []
for slug, title, desc in topics:
    html_content = html_template.format(slug=slug, title=title, description=desc)
    # Escape quotes
    html_content = html_content.replace("'", "''")
    inserts.append(f"('{slug}', '{title}', '{html_content}')")

sql_values = ",\n".join(inserts)

sql_block = f"""
-- Insert Theory Modules
INSERT INTO theory_modules (slug, title, content_html) VALUES
{sql_values};
"""

# Read database.sql
with open("f:\\DAW2\\MPO31 - Creació i gestió de llocs webs dinàmics\\pp10\\database.sql", "r", encoding="utf-8") as f:
    content = f.read()

# Use regex to replace the current INSERT INTO theory_modules ... ;
pattern = re.compile(r"-- Insert Theory Modules\s*INSERT INTO theory_modules.*?;\s*-- Insert Questions", re.DOTALL)
new_content = pattern.sub(f"{sql_block}\n\n-- Insert Questions", content)

with open("f:\\DAW2\\MPO31 - Creació i gestió de llocs webs dinàmics\\pp10\\database.sql", "w", encoding="utf-8") as f:
    f.write(new_content)

print("database.sql updated successfully with 50 modules.")
