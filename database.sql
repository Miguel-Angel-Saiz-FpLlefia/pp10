-- Limpiar datos antiguos para evitar errores de duplicados
DROP TABLE IF EXISTS scores CASCADE;
DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS theory_modules CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    xp INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS scores (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    xp_earned INT NOT NULL DEFAULT 0,
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS theory_modules (
    id SERIAL PRIMARY KEY,
    slug VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    content_html TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_0 VARCHAR(255) NOT NULL,
    option_1 VARCHAR(255) NOT NULL,
    option_2 VARCHAR(255) NOT NULL,
    option_3 TEXT NOT NULL,
    correct_answer_index INT NOT NULL,
    xp_reward INT DEFAULT 10,
    module_slug VARCHAR(50) DEFAULT 'general'
);

-- Insert Theory Modules
INSERT INTO theory_modules (slug, title, content_html) VALUES
('intro-shopify', 'Introducción a Shopify', '<div class="max-w-4xl mx-auto my-12 p-8 bg-white shadow-xl rounded-lg">
        
        <header class="border-b-2 border-green-500 pb-6 mb-8">
            <h1 class="text-4xl font-extrabold text-gray-900">
                El Ecosistema del <span class="text-green-600">E-commerce: Shopify</span>
            </h1>
            <p class="mt-4 text-lg text-gray-600">
                Basado en el análisis del modelo operativo de las plataformas modernas, 
                <span class="font-semibold text-gray-800">Shopify</span> se define como una solución SaaS (Software as a Service).
            </p>
        </header>

        <section class="mb-10">
            <div class="bg-blue-50 border-l-4 border-blue-500 p-4 mb-6">
                <p class="text-gray-700">
                    En términos sencillos, es un servicio <strong>"todo incluido"</strong> donde la empresa proveedora se encarga de toda la infraestructura técnica. A diferencia de Magento o WooCommerce, no requiere hosting externo ni mantenimiento manual de servidores.
                </p>
            </div>
        </section>

        <section class="mb-10">
            <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
                <svg class="w-6 h-6 mr-2 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                Características Clave y Ventajas Competitivas
            </h2>
            
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-200">
                    <thead>
                        <tr class="bg-gray-100 text-gray-700 uppercase text-sm leading-normal">
                            <th class="py-3 px-6 text-left border-b">Característica</th>
                            <th class="py-3 px-6 text-left border-b">Descripción</th>
                        </tr>
                    </thead>
                    <tbody class="text-gray-600 text-sm font-light">
                        <tr class="border-b border-gray-200 hover:bg-gray-50">
                            <td class="py-4 px-6 font-bold text-gray-800">Infraestructura gestionada</td>
                            <td class="py-4 px-6">Shopify se ocupa de que todo funcione sin gestión técnica compleja por parte del usuario.</td>
                        </tr>
                        <tr class="border-b border-gray-200 hover:bg-gray-50">
                            <td class="py-4 px-6 font-bold text-gray-800">Alta escalabilidad</td>
                            <td class="py-4 px-6">Soporta desde volúmenes bajos hasta picos de 10,000 transacciones por minuto sin caídas.</td>
                        </tr>
                        <tr class="border-b border-gray-200 hover:bg-gray-50">
                            <td class="py-4 px-6 font-bold text-gray-800">Seguridad</td>
                            <td class="py-4 px-6">Certificación Nivel 1 PCI DSS; procesamiento de pagos seguro de forma nativa.</td>
                        </tr>
                        <tr class="border-b border-gray-200 hover:bg-gray-50">
                            <td class="py-4 px-6 font-bold text-gray-800">Rendimiento (CDN Global)</td>
                            <td class="py-4 px-6">Uso de Fastly y Cloudflare para optimizar la velocidad de carga global.</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="mb-10">
            <h2 class="text-2xl font-bold text-gray-800 mb-4">Resumen de Beneficios</h2>
            <ul class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <li class="p-4 bg-green-50 rounded-lg border border-green-100 shadow-sm">
                    <span class="block font-bold text-green-700 mb-1">Costos Bajos</span>
                    Reducción de costos al eliminar mantenimiento de servidores.
                </li>
                <li class="p-4 bg-green-50 rounded-lg border border-green-100 shadow-sm">
                    <span class="block font-bold text-green-700 mb-1">Foco en Negocio</span>
                    Enfoque total en ventas y marketing, no en problemas técnicos.
                </li>
                <li class="p-4 bg-green-50 rounded-lg border border-green-100 shadow-sm">
                    <span class="block font-bold text-green-700 mb-1">Confianza</span>
                    Seguridad de estándar bancario para el consumidor final.
                </li>
            </ul>
        </section>

        <footer class="bg-gray-800 text-white p-6 rounded-lg text-center">
            <p class="text-lg italic">
                "Shopify se posiciona como una infraestructura robusta que permite a los negocios crecer de forma orgánica y segura en el mercado global."
            </p>
        </footer>

    </div>'),
    ('crear-cuenta', 'Creando la cuenta de shopify', '<div class="max-w-4xl mx-auto my-12 p-8 bg-white shadow-xl rounded-lg">
        
        <!-- Encabezado -->
        <header class="border-b-2 border-green-500 pb-6 mb-8 text-center">
            <h1 class="text-4xl font-extrabold text-gray-900">
                Cómo crear tu cuenta en <span class="text-green-600">Shopify</span>
            </h1>
            <p class="mt-4 text-lg text-gray-600">
                Sigue estos pasos para lanzar tu infraestructura robusta y segura.
            </p>
        </header>

        <!-- Pasos del Proceso -->
        <div class="space-y-8">
            
            <!-- Paso 1 -->
            <div class="flex items-start">
                <div class="flex-shrink-0 bg-green-600 text-white w-10 h-10 rounded-full flex items-center justify-center font-bold text-lg">1</div>
                <div class="ml-6">
                    <h3 class="text-xl font-bold text-gray-800">Registro Inicial</h3>
                    <p class="text-gray-600 mt-2">
                        Accede a la plataforma y haz clic en <strong>"Comenzar prueba gratuita"</strong>. Ingresa tu correo electrónico, crea una contraseña y define el nombre de tu tienda.
                    </p>
                </div>
            </div>

            <!-- Paso 2 -->
            <div class="flex items-start">
                <div class="flex-shrink-0 bg-green-600 text-white w-10 h-10 rounded-full flex items-center justify-center font-bold text-lg">2</div>
                <div class="ml-6">
                    <h3 class="text-xl font-bold text-gray-800">Configuración del Negocio</h3>
                    <p class="text-gray-600 mt-2">
                        Responde a las preguntas sobre tu industria y selecciona tu país. Esto es vital para que la infraestructura <strong>SaaS</strong> configure automáticamente impuestos y pasarelas de pago.
                    </p>
                </div>
            </div>

            <!-- Paso 3 -->
            <div class="flex items-start">
                <div class="flex-shrink-0 bg-green-600 text-white w-10 h-10 rounded-full flex items-center justify-center font-bold text-lg">3</div>
                <div class="ml-6">
                    <h3 class="text-xl font-bold text-gray-800">Selección de Plan</h3>
                    <p class="text-gray-600 mt-2">
                        Verifica tu correo y elige el plan que mejor se adapte a tu escala (Basic, Shopify o Advanced). Recuerda que Shopify garantiza <strong>Seguridad Nivel 1 PCI DSS</strong> en todos sus planes.
                    </p>
                </div>
            </div>

            <!-- Paso 4 -->
            <div class="flex items-start">
                <div class="flex-shrink-0 bg-green-600 text-white w-10 h-10 rounded-full flex items-center justify-center font-bold text-lg">4</div>
                <div class="ml-6">
                    <h3 class="text-xl font-bold text-gray-800">Personalización y Lanzamiento</h3>
                    <p class="text-gray-600 mt-2">
                        Configura tu tema, agrega tus primeros productos y activa tus métodos de pago para aprovechar el <strong>CDN Global</strong> y ofrecer una carga rápida a tus clientes.
                    </p>
                </div>
            </div>

        </div>

        <!-- Alerta de Beneficio -->
        <div class="mt-12 p-6 bg-yellow-50 border-l-4 border-yellow-400 rounded-r-lg">
            <div class="flex">
                <div class="flex-shrink-0">
                    <svg class="h-6 w-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
                <div class="ml-3">
                    <p class="text-sm text-yellow-700 font-medium">
                        <strong>Tip Pro:</strong> Al ser un modelo SaaS, no necesitas instalar nada en tu computadora. Todo se gestiona desde el panel de control en la nube.
                    </p>
                </div>
            </div>
        </div>

        <!-- Botón de Acción -->
        <div class="mt-10 text-center">
            <a href="#" class="inline-block px-8 py-3 bg-green-600 text-white font-bold rounded-full hover:bg-green-700 transition duration-300 shadow-lg">
                ¡Empezar ahora!
            </a>
        </div>

    </div>'),
('preparar-entorno', 'Preparando el entorno de shopify', '<div class="max-w-4xl mx-auto bg-white shadow-2xl rounded-2xl overflow-hidden">
        <!-- Header -->
        <div class="bg-indigo-700 p-8 text-white">
            <h1 class="text-3xl font-bold">Preparación del Entorno Local</h1>
            <p class="text-indigo-100 mt-2 opacity-90">Guía técnica para desarrolladores: Shopify CLI + VS Code</p>
        </div>

        <div class="p-8">
            <!-- Introducción -->
            <p class="text-gray-600 mb-8 border-b pb-4">
                Para extender la funcionalidad de Shopify más allá del panel de control, necesitamos conectar nuestra máquina local con la infraestructura <strong>SaaS</strong> de la tienda.
            </p>

            <!-- Pasos con Bloques de Código -->
            <div class="space-y-8">
                
                <!-- Paso 1 -->
                <div>
                    <h3 class="text-lg font-semibold text-indigo-700 flex items-center mb-3">
                        <span class="bg-indigo-100 text-indigo-700 rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm">1</span>
                        Instalar Shopify CLI
                    </h3>
                    <p class="text-gray-600 mb-2 text-sm">Usa Node.js para instalar la interfaz de comandos global.</p>
                    <div class="bg-gray-900 rounded-lg p-4 font-mono text-sm text-green-400">
                        npm install -g @shopify/cli @shopify/theme
                    </div>
                </div>

                <!-- Paso 2 -->
                <div>
                    <h3 class="text-lg font-semibold text-indigo-700 flex items-center mb-3">
                        <span class="bg-indigo-100 text-indigo-700 rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm">2</span>
                        Crear Proyecto Local (Dawn)
                    </h3>
                    <p class="text-gray-600 mb-2 text-sm">Clona el tema base estándar de Shopify para empezar a editar.</p>
                    <div class="bg-gray-900 rounded-lg p-4 font-mono text-sm text-green-400">
                        shopify theme init mi-nuevo-tema
                    </div>
                </div>

                <!-- Paso 3 -->
                <div>
                    <h3 class="text-lg font-semibold text-indigo-700 flex items-center mb-3">
                        <span class="bg-indigo-100 text-indigo-700 rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm">3</span>
                        VS Code y Conexión
                    </h3>
                    <p class="text-gray-600 mb-2 text-sm">Abre la carpeta y vincula tu terminal con la URL de tu tienda.</p>
                    <div class="bg-gray-900 rounded-lg p-4 font-mono text-sm text-green-400">
                        cd mi-nuevo-tema <br>
                        code . <br>
                        shopify auth login --store tu-tienda.myshopify.com
                    </div>
                </div>

                <!-- Paso 4 -->
                <div>
                    <h3 class="text-lg font-semibold text-indigo-700 flex items-center mb-3">
                        <span class="bg-indigo-100 text-indigo-700 rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm">4</span>
                        Servidor de Preview Local
                    </h3>
                    <p class="text-gray-600 mb-2 text-sm">Levanta un servidor local que sincroniza los cambios en tiempo real.</p>
                    <div class="bg-gray-900 rounded-lg p-4 font-mono text-sm text-green-400">
                        shopify theme dev
                    </div>
                </div>

            </div>

            <!-- Resumen Informativo -->
            <div class="mt-10 p-5 bg-indigo-50 rounded-xl border border-indigo-100">
                <h4 class="font-bold text-indigo-900 text-sm uppercase tracking-wider mb-2">¿Por qué es importante?</h4>
                <ul class="text-sm text-indigo-800 space-y-2 list-disc pl-5">
                    <li><strong>Sincronización:</strong> Los cambios se ven en una URL de preview segura antes de publicarse.</li>
                    <li><strong>Eficiencia:</strong> Permite usar extensiones de VS Code para editar archivos Liquid.</li>
                    <li><strong>Seguridad:</strong> No afecta la tienda en vivo hasta que decides hacer un <em>push</em>.</li>
                </ul>
            </div>
        </div>

        <!-- Footer -->
        <div class="bg-gray-100 p-4 text-center text-xs text-gray-500 italic">
            Entorno técnico configurado bajo estándares PCI DSS y optimizado para CDN Global.
        </div>
    </div>'),
('crear-productos', 'Crear productos en Shopify', '<div class="max-w-4xl mx-auto bg-white shadow-lg rounded-xl overflow-hidden">
        <!-- Encabezado con estilo Shopify -->
        <div class="bg-[#008060] p-6 text-white">
            <h1 class="text-2xl font-bold flex items-center">
                <svg class="w-8 h-8 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path></svg>
                Gestión de Inventario y Productos
            </h1>
        </div>

        <div class="p-8">
            <p class="text-gray-700 mb-6 italic">
                Al añadir productos, Shopify utiliza su <strong>CDN Global</strong> para procesar y servir las imágenes rápidamente a nivel mundial.
            </p>

            <!-- Pasos de creación -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                
                <!-- Paso 1 -->
                <div class="border border-gray-200 rounded-lg p-4 hover:border-green-500 transition-colors">
                    <h3 class="font-bold text-gray-800 mb-2 underline decoration-green-500">1. Detalles Básicos</h3>
                    <p class="text-sm text-gray-600">
                        Ve a <strong>Productos > Agregar producto</strong>. Define el título, descripción optimizada para SEO y carga imágenes en alta resolución.
                    </p>
                </div>

                <!-- Paso 2 -->
                <div class="border border-gray-200 rounded-lg p-4 hover:border-green-500 transition-colors">
                    <h3 class="font-bold text-gray-800 mb-2 underline decoration-green-500">2. Precios y Stock</h3>
                    <p class="text-sm text-gray-600">
                        Configura el precio, el costo por artículo y el SKU. Shopify se encarga de la <strong>escalabilidad</strong> para rastrear el inventario en tiempo real[cite: 1].
                    </p>
                </div>

                <!-- Paso 3 -->
                <div class="border border-gray-200 rounded-lg p-4 hover:border-green-500 transition-colors">
                    <h3 class="font-bold text-gray-800 mb-2 underline decoration-green-500">3. Variantes</h3>
                    <p class="text-sm text-gray-600">
                        Si tu producto tiene tallas o colores, añade variantes. Cada una puede tener su propio precio, stock e imagen específica.
                    </p>
                </div>

                <!-- Paso 4 -->
                <div class="border border-gray-200 rounded-lg p-4 hover:border-green-500 transition-colors">
                    <h3 class="font-bold text-gray-800 mb-2 underline decoration-green-500">4. Organización</h3>
                    <p class="text-sm text-gray-600">
                        Asigna el producto a una <strong>Colección</strong> y añade etiquetas (tags) para facilitar la búsqueda en el frontend del tema Dawn.
                    </p>
                </div>
            </div>

            <!-- Nota Técnica -->
            <div class="mt-8 bg-gray-50 p-6 rounded-lg border-l-4 border-green-600">
                <h4 class="text-green-800 font-bold mb-2 uppercase text-xs tracking-widest">Dato Importante</h4>
                <p class="text-sm text-gray-700">
                    Gracias al modelo <strong>SaaS</strong>, no necesitas configurar bases de datos para tus productos; Shopify almacena y asegura toda la información bajo estándares <strong>PCI DSS</strong>[cite: 1].
                </p>
            </div>
        </div>

        <!-- Footer -->
        <div class="bg-gray-100 p-4 text-center">
            <button class="bg-[#008060] hover:bg-[#005e46] text-white font-bold py-2 px-6 rounded-md transition duration-300">
                Guardar Producto
            </button>
        </div>
    </div>'),
('Colecciones', 'Las colecciones de Shopify', '<div class="max-w-5xl mx-auto bg-white shadow-2xl rounded-3xl overflow-hidden border border-gray-200">
        
        <!-- Header -->
        <div class="bg-gradient-to-r from-green-700 to-green-900 p-8 text-white">
            <h1 class="text-3xl font-extrabold tracking-tight">Gestión de Colecciones</h1>
            <p class="mt-2 text-green-100 opacity-90">Organiza tu inventario para mejorar la experiencia de usuario y el rendimiento del sitio.</p>
        </div>

        <div class="p-8">
            <!-- Definición -->
            <div class="mb-10">
                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                    <span class="w-2 h-8 bg-green-500 mr-3 rounded-full"></span>
                    ¿Qué es una Colección?
                </h2>
                <p class="text-gray-600 leading-relaxed">
                    Es una herramienta de agrupación que permite clasificar productos por categorías (ej. "Ropa de Verano", "Ofertas"). Gracias al **CDN Global** de Shopify, las páginas de colección cargan de forma instantánea al servir las imágenes desde el punto más cercano al cliente.
                </p>
            </div>

            <!-- Tipos de Colección -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
                <div class="p-6 rounded-2xl bg-blue-50 border border-blue-100">
                    <h3 class="font-bold text-blue-800 mb-2 font-mono">Tipo: Manual</h3>
                    <p class="text-sm text-blue-700">Perfectas para curaciones específicas o lanzamientos exclusivos donde el control es total.</p>
                </div>
                <div class="p-6 rounded-2xl bg-purple-50 border border-purple-100">
                    <h3 class="font-bold text-purple-800 mb-2 font-mono">Tipo: Automatizada</h3>
                    <p class="text-sm text-purple-700">Utiliza la <strong>infraestructura gestionada</strong> para incluir productos automáticamente mediante reglas de filtrado[cite: 1].</p>
                </div>
            </div>

            <!-- Pasos de Creación -->
            <h2 class="text-xl font-bold text-gray-800 mb-6">Proceso de Creación</h2>
            <div class="space-y-6">
                <!-- Paso 1 -->
                <div class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition">
                    <div class="text-2xl font-black text-gray-300 mr-6 italic">01</div>
                    <div>
                        <h4 class="font-bold text-gray-800">Acceso</h4>
                        <p class="text-sm text-gray-600">Navega a <strong>Productos > Colecciones</strong> y haz clic en "Crear colección".</p>
                    </div>
                </div>

                <!-- Paso 2 -->
                <div class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition">
                    <div class="text-2xl font-black text-gray-300 mr-6 italic">02</div>
                    <div>
                        <h4 class="font-bold text-gray-800">Identidad</h4>
                        <p class="text-sm text-gray-600">Asigna un título atractivo y una imagen de portada optimizada para el tema local (como Dawn).</p>
                    </div>
                </div>

                <!-- Paso 3 -->
                <div class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition">
                    <div class="text-2xl font-black text-gray-300 mr-6 italic">03</div>
                    <div>
                        <h4 class="font-bold text-gray-800">Configuración de Reglas</h4>
                        <p class="text-sm text-gray-600">Si es automatizada, establece condiciones basadas en el inventario o etiquetas para mantener la <strong>escalabilidad</strong>[cite: 1].</p>
                    </div>
                </div>
            </div>

            <!-- Nota de Seguridad -->
            <div class="mt-12 bg-yellow-50 p-6 rounded-2xl border-dashed border-2 border-yellow-200">
                <p class="text-sm text-yellow-800 flex">
                    <svg class="w-5 h-5 mr-2 text-yellow-600" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>
                    <strong>Seguridad PCI DSS:</strong> Toda la información de tus productos y colecciones está cifrada y protegida nativamente por la plataforma[cite: 1].
                </p>
            </div>
        </div>

        <!-- Footer -->
        <div class="bg-gray-50 p-6 border-t border-gray-100 text-center">
            <p class="text-xs text-gray-400 uppercase tracking-widest font-semibold">Shopify SaaS Ecosystem 2026</p>
        </div>
    </div>'),
('liquid', 'liquid', '<div class="max-w-4xl mx-auto bg-white shadow-2xl rounded-3xl overflow-hidden">
        
        <!-- Header -->
        <div class="bg-slate-900 p-8 text-white">
            <h1 class="text-3xl font-bold flex items-center">
                <span class="text-blue-400 mr-3 italic">{ }</span> Liquid: El Motor de Shopify
            </h1>
            <p class="text-slate-400 mt-2">Personaliza el frontend de tu infraestructura SaaS con precisión técnica.</p>
        </div>

        <div class="p-8">
            <!-- Conceptos Fundamentales -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-10">
                <div class="p-4 bg-orange-50 border-t-4 border-orange-400 rounded-lg text-center">
                    <span class="text-2xl block mb-2">🏷️</span>
                    <h3 class="font-bold text-orange-800">Objetos</h3>
                    <p class="text-xs text-orange-700 mt-1">Envueltos en <code class="bg-orange-100 px-1">{{ }}</code>. Representan datos (ej. nombre del producto).</p>
                </div>
                <div class="p-4 bg-blue-50 border-t-4 border-blue-400 rounded-lg text-center">
                    <span class="text-2xl block mb-2">⚙️</span>
                    <h3 class="font-bold text-blue-800">Tags</h3>
                    <p class="text-xs text-blue-700 mt-1">Envueltos en <code class="bg-blue-100 px-1">{% %}</code>. Lógica (if, for loops, asignaciones).</p>
                </div>
                <div class="p-4 bg-green-50 border-t-4 border-green-400 rounded-lg text-center">
                    <span class="text-2xl block mb-2">🧪</span>
                    <h3 class="font-bold text-green-800">Filtros</h3>
                    <p class="text-xs text-green-700 mt-1">Usan el símbolo <code class="bg-green-100 px-1">|</code>. Modifican la salida (ej. cambiar moneda).</p>
                </div>
            </div>

            <!-- Cómo modificar cosas -->
            <h2 class="text-2xl font-bold text-slate-800 mb-6">¿Cómo modificar tu tienda?</h2>
            
            <div class="space-y-6">
                <!-- Método 1 -->
                <div class="flex items-start bg-slate-50 p-6 rounded-xl border border-slate-200">
                    <div class="bg-blue-600 text-white p-3 rounded-lg mr-4">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                    </div>
                    <div>
                        <h4 class="font-bold text-slate-900">Vía Editor Visual</h4>
                        <p class="text-sm text-slate-600 mt-1">Para cambios estéticos rápidos en temas como <strong>Dawn</strong> sin tocar código.</p>
                    </div>
                </div>

                <!-- Método 2 -->
                <div class="flex items-start bg-slate-50 p-6 rounded-xl border border-slate-200">
                    <div class="bg-purple-600 text-white p-3 rounded-lg mr-4">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"></path></svg>
                    </div>
                    <div>
                        <h4 class="font-bold text-slate-900">Vía Edición de Código (Liquid)</h4>
                        <p class="text-sm text-slate-600 mt-1">Accediendo a <strong>Tienda Online > Temas > Editar código</strong> para modificar archivos <code class="text-pink-600">.liquid</code>.</p>
                    </div>
                </div>

                <!-- Método 3 -->
                <div class="flex items-start bg-slate-50 p-6 rounded-xl border border-slate-200">
                    <div class="bg-green-600 text-white p-3 rounded-lg mr-4">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z"></path></svg>
                    </div>
                    <div>
                        <h4 class="font-bold text-slate-900">Vía Shopify CLI</h4>
                        <p class="text-sm text-slate-600 mt-1">Uso de <strong>shopify theme dev</strong> para previsualizar cambios locales antes de subirlos a la nube del CDN Global.</p>
                    </div>
                </div>
            </div>

            <!-- Ejemplo Práctico -->
            <div class="mt-10">
                <h4 class="text-sm font-bold text-slate-500 uppercase tracking-widest mb-3 text-center">Ejemplo de código Liquid</h4>
                <div class="bg-slate-900 rounded-2xl p-6 font-mono text-sm shadow-inner">
                    <p class="text-green-400">{% <span class="text-blue-400">if</span> product.available %}</p>
                    <p class="text-white ml-6">&lt;span class="badge"&gt;¡En stock!&lt;/span&gt;</p>
                    <p class="text-green-400">{% <span class="text-blue-400">else</span> %}</p>
                    <p class="text-white ml-6">&lt;span class="alert"&gt;Agotado&lt;/span&gt;</p>
                    <p class="text-green-400">{% <span class="text-blue-400">endif</span> %}</p>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="bg-slate-50 p-6 text-center border-t border-slate-100">
            <p class="text-xs text-slate-400">
                Aprovecha la <strong>Escalabilidad</strong> y el <strong>Rendimiento</strong> de Shopify mediante el uso eficiente de Liquid[cite: 1].
            </p>
        </div>
    </div>'),
('teoria-sobre-liquid', 'Teoria sobre liquid', '<div class="max-w-4xl mx-auto bg-white shadow-xl rounded-2xl overflow-hidden border border-gray-100">
        
        <!-- Header -->
        <div class="bg-gradient-to-r from-blue-900 to-indigo-800 p-8 text-white">
            <h1 class="text-3xl font-bold">Arquitectura de Liquid</h1>
            <p class="text-blue-200 mt-2 italic">Entendiendo el ciclo de renderizado en una infraestructura SaaS.</p>
        </div>

        <div class="p-8">
            <!-- Cómo funciona el renderizado -->
            <section class="mb-12">
                <h2 class="text-2xl font-bold text-gray-800 mb-4">El Ciclo de Renderizado</h2>
                <div class="bg-indigo-50 p-6 rounded-xl border-l-4 border-indigo-500">
                    <p class="text-gray-700 leading-relaxed">
                        Cuando un usuario visita una tienda, Shopify procesa el código Liquid en sus servidores antes de enviar nada al navegador. 
                        Este proceso convierte las etiquetas dinámicas en HTML estático, lo que garantiza que el cliente nunca vea el código fuente del servidor, manteniendo la <strong>seguridad Nivel 1 PCI DSS</strong>.
                    </p>
                </div>
            </section>

            <!-- Tres Pilares Técnicos -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
                <div>
                    <h3 class="text-lg font-bold text-indigo-700 mb-2">1. Objetos (Data)</h3>
                    <p class="text-sm text-gray-600 mb-4">
                        Son variables que contienen información de la tienda. Por ejemplo, el objeto <code>product</code> contiene el título, precio e imágenes que el <strong>CDN Global</strong> sirve rápidamente.
                    </p>
                    <div class="bg-gray-900 text-pink-400 p-3 rounded-md font-mono text-xs">
                        {{ product.title }}
                    </div>
                </div>
                <div>
                    <h3 class="text-lg font-bold text-indigo-700 mb-2">2. Tags (Lógica)</h3>
                    <p class="text-sm text-gray-600 mb-4">
                        Controlan el flujo del programa. Permiten crear bucles para listar productos o condiciones para mostrar contenido específico basándose en la <strong>escalabilidad</strong> del inventario[cite: 1].
                    </p>
                    <div class="bg-gray-900 text-blue-400 p-3 rounded-md font-mono text-xs">
                        {% if product.available %} ... {% endif %}
                    </div>
                </div>
            </div>

            <!-- El concepto de Filtros -->
            <section class="mb-12">
                <h3 class="text-lg font-bold text-indigo-700 mb-4">3. Filtros (Manipulación)</h3>
                <p class="text-sm text-gray-600 mb-4">
                    Los filtros modifican la salida de los objetos. Son esenciales para formatear fechas, monedas o redimensionar imágenes que se distribuyen por la red de Fastly y Cloudflare[cite: 1].
                </p>
                <div class="bg-slate-100 p-4 rounded-lg flex items-center justify-between font-mono text-sm border border-slate-200">
                    <span class="text-gray-500">Entrada: 10.5</span>
                    <span class="text-indigo-600 font-bold">| money</span>
                    <span class="text-green-600">Salida: $10.50</span>
                </div>
            </section>

            <!-- Comparativa SaaS vs Tradicional -->
            <div class="bg-gray-50 p-6 rounded-2xl border border-gray-200">
                <h4 class="font-bold text-gray-800 mb-3 text-center">Liquid en el Ecosistema SaaS</h4>
                <div class="space-y-4">
                    <div class="flex items-center">
                        <div class="w-4 h-4 bg-green-500 rounded-full mr-3"></div>
                        <p class="text-sm text-gray-600"><strong>Abstracción:</strong> Liquid evita que el desarrollador tenga que preocuparse por el mantenimiento de servidores o bases de datos[cite: 1].</p>
                    </div>
                    <div class="flex items-center">
                        <div class="w-4 h-4 bg-green-500 rounded-full mr-3"></div>
                        <p class="text-sm text-gray-600"><strong>Rendimiento:</strong> Al ser procesado nativamente por Shopify, aprovecha el <strong>CDN Global</strong> para minimizar la latencia[cite: 1].</p>
                    </div>
                    <div class="flex items-center">
                        <div class="w-4 h-4 bg-green-500 rounded-full mr-3"></div>
                        <p class="text-sm text-gray-600"><strong>Seguridad:</strong> No permite acceso directo al sistema de archivos, eliminando vulnerabilidades comunes en otras plataformas[cite: 1].</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="bg-slate-900 p-4 text-center">
            <p class="text-xs text-slate-500 tracking-widest uppercase">Arquitectura Liquid • Shopify Core 2026</p>
        </div>
    </div>'),
('colecciones-manuales', 'Colecciones Manuales', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Curación de Productos</h2>
            <p class=''mb-4''>Las colecciones manuales permiten agrupar productos seleccionándolos uno por uno. Son ideales para:</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li>Campañas estacionales (ej. ''Rebajas de Verano'').</li>
                <li>Lookbooks o colecciones cápsula muy específicas.</li>
            </ul>
            <h3 class=''text-xl font-bold mb-2''>Ordenación Personalizada</h3>
            <p>A diferencia de las automatizadas, las colecciones manuales permiten el arrastrar y soltar (drag & drop) para elegir exactamente en qué orden aparecen los productos en el frontend, lo cual es crucial para estrategias de merchandising visual.</p>
        </div>'),
('colecciones-automatizadas', 'Colecciones Automatizadas', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Escalabilidad del Catálogo</h2>
            <p class=''mb-4''>Las colecciones automatizadas añaden productos basándose en reglas condicionales, eliminando el trabajo manual en catálogos grandes.</p>
            <h3 class=''text-xl font-bold mb-2''>Reglas Comunes</h3>
            <pre class=''bg-gray-800 text-blue-300 p-4 rounded mb-4''><code>
1. Etiqueta del producto ES IGUAL A ''novedad''
2. Precio del producto ES MAYOR QUE 50
3. Inventario disponible ES MAYOR QUE 0
            </code></pre>
            <p><strong>Nota técnica:</strong> Las condiciones pueden configurarse para cumplir <em>todas</em> (AND) o <em>cualquier</em> condición (OR). Es la base del SEO estructurado en grandes e-commerce.</p>
        </div>'),
('inventario-ubicaciones', 'Inventario y Ubicaciones', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Gestión Omnicanal</h2>
            <p class=''mb-4''>Shopify permite rastrear inventario en múltiples <strong>Locations</strong> (tiendas físicas, almacenes o centros logísticos externos).</p>
            <h3 class=''text-xl font-bold mb-2''>Prioridad de Fulfillment</h3>
            <p class=''mb-4''>Cuando entra un pedido, el algoritmo de Shopify decide desde qué almacén descontar el stock basándose en las reglas de enrutamiento (Order Routing).</p>
            <p>Como desarrollador, cuando consultas la disponibilidad en Liquid, <code>product.available</code> verifica todas las ubicaciones. Si necesitas verificar el stock en una tienda específica para Click & Collect, usarás la Storefront API.</p>
        </div>'),
('etiquetas-tags', 'Sistema de Etiquetas (Tags)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Metadatos Flexibles</h2>
            <p class=''mb-4''>Los tags son cadenas de texto simples que se pueden añadir a Productos, Pedidos, Clientes y Artículos de Blog.</p>
            <h3 class=''text-xl font-bold mb-2''>Casos de Uso Principales</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Productos:</strong> Filtros en la barra lateral del catálogo (ej. tag ''material-cuero'').</li>
                <li><strong>Clientes:</strong> Asignar niveles VIP (ej. tag ''mayorista'') para alterar precios vía Liquid.</li>
                <li><strong>Pedidos:</strong> Marcar pedidos fraudulentos o que requieren revisión manual.</li>
            </ul>
            <p>Tienen un límite estricto de 250 tags por producto y no admiten estructuras clave-valor (para eso usamos Metafields).</p>
        </div>'),
('metafields-intro', 'Introducción a los Metafields', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Extensión de Datos Nativos</h2>
            <p class=''mb-4''>Los metafields son la respuesta de Shopify para almacenar información estructurada adicional que no viene por defecto en la plataforma.</p>
            <h3 class=''text-xl font-bold mb-2''>Estructura de un Metafield</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Namespace:</strong> Agrupación lógica (ej. <code>instrucciones</code>).</li>
                <li><strong>Key:</strong> Identificador (ej. <code>lavado</code>).</li>
                <li><strong>Type:</strong> Tipo de dato (String, Integer, Color, JSON).</li>
            </ul>
            <pre class=''bg-gray-800 text-pink-400 p-4 rounded mb-4''><code>
{{ product.metafields.instrucciones.lavado.value }}
            </code></pre>
            <p>Se pueden conectar directamente con el Theme Editor usando Fuentes Dinámicas (Dynamic Sources) en OS 2.0.</p>
        </div>'),
('metaobjects-intro', 'Metaobjects: Tablas Personalizadas', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Base de Datos Relacional en Shopify</h2>
            <p class=''mb-4''>A diferencia de los Metafields (que se unen a un producto específico), los <strong>Metaobjects</strong> son entidades independientes. Actúan como tablas de base de datos personalizadas.</p>
            <h3 class=''text-xl font-bold mb-2''>Ejemplo: ''Diseñadores''</h3>
            <p class=''mb-4''>Puedes crear un Metaobject llamado <em>Designer</em> con campos: Nombre, Biografía, e Imagen. Luego, en el producto, creas un Metafield de tipo ''Referencia a Metaobject'' apuntando a un diseñador.</p>
            <p>Además, los Metaobjects pueden generar <strong>Webpages Dinámicas</strong>, permitiendo crear páginas SEO para cada diseñador automáticamente sin tocar código.</p>
        </div>'),
('clientes-segmentacion', 'Gestión y Segmentación de Clientes', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El CRM de Shopify</h2>
            <p class=''mb-4''>El panel de clientes almacena historial de compras, valor total de vida (LTV) y consentimientos de marketing.</p>
            <h3 class=''text-xl font-bold mb-2''>Segmentos</h3>
            <p class=''mb-4''>Utilizando el lenguaje de consulta de Shopify (ShopifyQL), puedes crear segmentos dinámicos que se actualizan en tiempo real:</p>
            <pre class=''bg-gray-800 text-blue-300 p-4 rounded mb-4''><code>
customer_tags CONTAINS ''VIP'' AND amount_spent > 1000
            </code></pre>
            <p>Estos segmentos son vitales para campañas de email marketing en Shopify Email o exportarlos a Klaviyo.</p>
        </div>'),
('b2b-shopify', 'B2B en Shopify', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Venta Mayorista (Exclusivo Plus)</h2>
            <p class=''mb-4''>Shopify B2B transforma la plataforma de B2C a un modelo mixto, permitiendo vender al por mayor y al consumidor final desde una misma tienda.</p>
            <h3 class=''text-xl font-bold mb-2''>Funcionalidades Core</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Empresas (Companies):</strong> Entidad que agrupa a múltiples compradores con roles asignados.</li>
                <li><strong>Catálogos de Precios:</strong> Listas de precios específicas o descuentos por porcentaje asignadas a cada empresa.</li>
                <li><strong>Condiciones de Pago:</strong> Soporte para ''Net 30'', ''Net 60'' o borradores de pedido que requieren aprobación previa.</li>
            </ul>
        </div>'),
('canales-venta', 'Canales de Venta', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Distribución Multicanal</h2>
            <p class=''mb-4''>La tienda online es solo <em>un</em> canal de venta. Shopify actúa como el cerebro (PIM y OMS) que distribuye el catálogo a múltiples frentes.</p>
            <h3 class=''text-xl font-bold mb-2''>Integraciones Clave</h3>
            <p class=''mb-4''><strong>Google & YouTube:</strong> Sincroniza productos mediante API con el Google Merchant Center para Shopping Ads.</p>
            <p><strong>Shop App:</strong> La aplicación nativa de Shopify para compradores, con Shop Pay integrado que dispara la tasa de conversión hasta un 50% por su checkout acelerado en 1 clic.</p>
        </div>'),
('shopify-pos', 'Shopify POS (Punto de Venta)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Integración Físico-Digital</h2>
            <p class=''mb-4''>La aplicación POS permite usar el mismo backend de Shopify en tiendas de ladrillo y mortero mediante iPads o hardware propio (POS Go).</p>
            <h3 class=''text-xl font-bold mb-2''>Operaciones Unificadas</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Buy Online, Pick Up In Store (BOPIS):</strong> El cliente compra en la web y el pedido aparece instantáneamente en el iPad de la tienda física para ser preparado.</li>
                <li><strong>Ship to Home:</strong> Vender un producto en la tienda física que no tiene stock local, ordenando el envío desde el almacén central.</li>
            </ul>
        </div>'),
('pedidos-fulfillment', 'Gestión de Pedidos y Fulfillment', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Ciclo de Vida del Pedido</h2>
            <p class=''mb-4''>Un pedido pasa por varios estados financieros y de preparación logística.</p>
            <h3 class=''text-xl font-bold mb-2''>Estados Financieros</h3>
            <p class=''mb-4''>Puede ser <em>Authorized</em> (tarjeta válida, fondos retenidos) o <em>Paid</em> (capturado). Capturar manualmente previene el fraude y ahorra comisiones por devoluciones si no hay stock.</p>
            <h3 class=''text-xl font-bold mb-2''>Estados de Fulfillment</h3>
            <p>Cuando empaquetas el pedido e introduces el tracking number (ej. FedEx, Correos), el pedido pasa a <em>Fulfilled</em> y se dispara automáticamente el email de envío al cliente final.</p>
        </div>'),
('devoluciones-reembolsos', 'Devoluciones y Reembolsos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Gestión de Inversas</h2>
            <p class=''mb-4''>Shopify integra un sistema de RMAs (Return Merchandise Authorization) para agilizar las quejas.</p>
            <h3 class=''text-xl font-bold mb-2''>El Flujo de Reembolso</h3>
            <ol class=''list-decimal pl-5 mb-4''>
                <li>El cliente solicita la devolución (vía portal o atención al cliente).</li>
                <li>El comerciante aprueba y genera una etiqueta de envío de retorno (Return Label).</li>
                <li>Al recibir e inspeccionar el paquete, se procesa el reembolso (Restocking) que devuelve el producto al inventario y el dinero a la tarjeta original.</li>
            </ol>
            <p>Se pueden cobrar ''Restocking Fees'' (tarifas de reposición) deduciéndolas del reembolso total.</p>
        </div>'),
('shopify-markets', 'Shopify Markets', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Expansión Internacional Nativa</h2>
            <p class=''mb-4''>Antes, vender en múltiples países requería múltiples tiendas (ej. tienda .es y tienda .com). Markets unifica esto en una sola instancia.</p>
            <h3 class=''text-xl font-bold mb-2''>Configuración por Mercado</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Monedas locales:</strong> Conversión de precios en tiempo real o precios fijos por región.</li>
                <li><strong>Dominios y Subcarpetas:</strong> Configuración de URLs específicas (ej. <code>tienda.com/es-mx/</code> para México).</li>
                <li><strong>Traducciones:</strong> Integración con la app Translate & Adapt para mantener el catálogo en varios idiomas sincronizado.</li>
            </ul>
        </div>'),
('impuestos-taxes', 'Configuración de Impuestos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Complejidad Fiscal Automatizada</h2>
            <p class=''mb-4''>El motor de impuestos determina cuánto cobrar basado en el origen y destino del pedido.</p>
            <h3 class=''text-xl font-bold mb-2''>Conceptos Clave</h3>
            <p class=''mb-4''><strong>Tax Overrides:</strong> Reglas especiales (ej. ropa infantil sin IVA en algunos países).</p>
            <p>En EE.UU., Shopify Tax calcula los impuestos a nivel estatal, de condado y municipal basándose en el <em>Nexus</em> (presencia física o económica de la empresa). Para Europa, gestiona las normativas VAT e IOSS automáticamente.</p>
        </div>'),
('envios-zonas', 'Perfiles y Zonas de Envío', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Lógica de Transporte</h2>
            <p class=''mb-4''>Los gastos de envío son el motivo #1 de abandono de carritos. Su configuración requiere precisión.</p>
            <h3 class=''text-xl font-bold mb-2''>Perfiles Generales vs Especiales</h3>
            <p class=''mb-4''>Puedes cobrar 5€ por camisetas (Perfil General) pero 50€ por bicicletas (Perfil Frágil/Pesado). Los perfiles agrupan productos.</p>
            <h3 class=''text-xl font-bold mb-2''>Reglas Condicionales</h3>
            <p>Puedes cobrar envío en base al precio total del carrito (ej. > 50€ = Envío Gratis) o al peso total (ej. > 5kg = 10€). Shopify evalúa la dirección del cliente, cruza con la Zona y aplica la tarifa correspondiente.</p>
        </div>'),
('pasarelas-pago', 'Shopify Payments y Pasarelas', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Flujos de Capital</h2>
            <p class=''mb-4''><strong>Shopify Payments</strong> es la pasarela nativa (marca blanca de Stripe). Evita comisiones de transacción adicionales, integra Apple Pay, Google Pay y métodos locales (Bancontact, iDEAL, Klarna).</p>
            <h3 class=''text-xl font-bold mb-2''>Pasarelas de Terceros</h3>
            <p>Si usas Redsys o PayPal como proveedor externo, Shopify cobra un % extra de penalización según el plan (2%, 1% o 0.5%). Integrar métodos de pago externos en el nuevo checkout requiere crear una <em>Payments App</em> bajo la nueva arquitectura web.</p>
        </div>'),
('checkout-configuracion', 'Configuración del Checkout', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Embudo Final</h2>
            <p class=''mb-4''>El checkout de Shopify procesa miles de millones de dólares y está hiper-optimizado. Los planes estándar solo pueden modificar su aspecto visual (colores, logo, fuentes) desde el Theme Editor.</p>
            <h3 class=''text-xl font-bold mb-2''>Campos de Formulario</h3>
            <p>Puedes configurar si requerir el teléfono, el nombre de empresa o habilitar la ''Propinas''. También es el lugar donde se configura el checkbox de suscripción al newsletter (marketing opt-in) vital para estrategias de retención.</p>
        </div>'),
('checkout-extensibility', 'Checkout Extensibility (Plus)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Revolución para Developers</h2>
            <p class=''mb-4''>Antiguamente, modificar el checkout requería inyectar código en el archivo oculto <code>checkout.liquid</code>. Esto era frágil y causaba fallos de seguridad.</p>
            <h3 class=''text-xl font-bold mb-2''>App Blocks & Web Components</h3>
            <p>Exclusivo para Plus. Ahora los desarrolladores construyen <strong>Checkout UI Extensions</strong> en React. Estas extensiones se ejecutan en un entorno sandbox seguro (WebWorker). Permiten añadir banners, campos personalizados (ej. número de pasaporte) o upsells post-compra sin comprometer la PCI Compliance.</p>
        </div>'),
('descuentos-cupones', 'Descuentos y Códigos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Estrategias Promocionales</h2>
            <p class=''mb-4''>El motor de descuentos soporta: Porcentaje fijo, Monto fijo, Envío Gratis y Compra X Lleva Y (BOGO).</p>
            <h3 class=''text-xl font-bold mb-2''>Combinabilidad</h3>
            <p>Recientemente, Shopify añadió la capacidad de <strong>combinar descuentos</strong>. Un cliente puede aplicar un código de 10% de descuento Y un código de envío gratis simultáneamente si el comerciante lo permite en la configuración de clase del descuento.</p>
        </div>'),
('descuentos-automaticos', 'Descuentos Automáticos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Conversión sin Fricción</h2>
            <p class=''mb-4''>A diferencia de los cupones que el usuario debe buscar y escribir en el checkout (lo que causa salidas hacia Google buscando ''cupones de descuento''), los descuentos automáticos se aplican solos en el carrito cuando se cumplen condiciones lógicas.</p>
            <h3 class=''text-xl font-bold mb-2''>Ejemplos de Aplicación</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Volumen:</strong> 20% OFF en todos los accesorios al comprar un ordenador.</li>
                <li><strong>Flash Sales:</strong> Todos los productos de la colección ''Invierno'' rebajados sin usar el campo de ''precio comparado'' producto a producto.</li>
            </ul>
        </div>'),
('tarjetas-regalo', 'Tarjetas de Regalo (Gift Cards)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Micro-economía del E-commerce</h2>
            <p class=''mb-4''>Las Gift Cards en Shopify se comportan como un producto pero no generan un revenue real hasta que son canjeadas (principio contable de pasivo diferido). Se envían por email con un código único y pueden ser agregadas a Apple Wallet.</p>
            <p><strong>Casos de desarrollo:</strong> Si usas la API de Admin, puedes emitir Gift Cards masivamente como compensación a clientes en lugar de emitir un reembolso de dinero a la tarjeta (mejorando el Cash Flow).</p>
        </div>'),
('marketing-basico', 'Marketing y Retención', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Ciclo de Vida del Cliente</h2>
            <p class=''mb-4''>El coste de adquisición (CAC) es alto. La rentabilidad viene de la retención. Shopify incluye herramientas nativas como Shopify Email (gratis hasta 10,000 correos al mes) para enviar newsletters directamente desde el panel.</p>
            <h3 class=''text-xl font-bold mb-2''>Automatizaciones Base</h3>
            <p>El flujo más crítico es el de <strong>Carrito Abandonado</strong>. Si un usuario introduce su email en el checkout pero no paga, Shopify retiene esa sesión y puede enviar un correo a las 10 horas ofreciendo un 5% de descuento para cerrar la venta.</p>
        </div>'),
('seo-basico', 'SEO Técnico en Shopify', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Visibilidad Orgánica</h2>
            <p class=''mb-4''>Shopify auto-genera y mantiene los archivos <code>sitemap.xml</code> y <code>robots.txt</code>. Permite editar libremente el Title, Meta Description y URL Handle de cada recurso.</p>
            <h3 class=''text-xl font-bold mb-2''>Consideraciones Estructurales</h3>
            <p>Las URLs en Shopify tienen un formato rígido. Un producto siempre estará en <code>/products/nombre</code> y una colección en <code>/collections/nombre</code>. Un error común es enlazar a un producto *dentro* de una colección (<code>/collections/zapatos/products/zapato1</code>) lo que genera contenido duplicado a ojos de Google. Como desarrollador, debes asegurarte que el tema enlaza usando el filtro de Liquid <code>within: collection</code> con cuidado o mejor, forzar URLs canónicas.</p>
        </div>'),
('redirecciones-301', 'Redirecciones 301', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Migraciones Sin Dolor</h2>
            <p class=''mb-4''>Cuando un cliente migra de Prestashop a Shopify, sus URLs antiguas dejarán de funcionar (Error 404), perdiendo todo su posicionamiento en Google.</p>
            <p>En <em>Navegación > Redirecciones de URL</em>, puedes importar un CSV que le diga a Shopify: ''Si alguien entra a <code>/catalogo.php?id=12</code>, redirígelo permanentemente (Código 301) a <code>/products/zapatilla-nike</code>''. Esto traspasa la autoridad del enlace (Link Juice).</p>
        </div>'),
('analitica-reportes', 'Analítica y Reportes', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Business Intelligence</h2>
            <p class=''mb-4''>Shopify centraliza los datos (sesiones, ventas por UTMs de campañas, retornos, CAC). La métrica reina es la <strong>Tasa de Conversión (CR)</strong>, que mide el % de sesiones que acaban en compra (promedio sector 1.5% - 2.5%).</p>
            <h3 class=''text-xl font-bold mb-2''>Integraciones</h3>
            <p>Aunque el panel de Shopify es robusto, siempre debe complementarse con Google Analytics 4 (mediante la app nativa de Google Channel) para analizar mapas de calor, flujos de navegación complejos y comportamiento de abandono de embudo detallado.</p>
        </div>'),
('liquid-sintaxis', 'Liquid: Sintaxis Básica', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Lenguaje del Frontend</h2>
            <p class=''mb-4''>Liquid es un motor de plantillas de código abierto creado por Shopify escrito originalmente en Ruby. No es PHP, se ejecuta en el servidor y devuelve HTML puro.</p>
            <h3 class=''text-xl font-bold mb-2''>Bloques Principales</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Output (Doble llave):</strong> <code>{{ product.title }}</code> -> Imprime el título del producto.</li>
                <li><strong>Tags (Llave y porcentaje):</strong> <code>{% if user %} Hola {% endif %}</code> -> Ejecuta lógica (condicionales, bucles).</li>
                <li><strong>Filtros (Barra vertical):</strong> <code>{{ ''hola'' | upcase }}</code> -> Transforma el output a ''HOLA''.</li>
            </ul>
        </div>'),
('liquid-filtros', 'Liquid: Filtros Avanzados', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Manipulación de Datos al Vuelo</h2>
            <p class=''mb-4''>Los filtros permiten procesar la información directamente en la plantilla sin requerir lógica en el backend.</p>
            <h3 class=''text-xl font-bold mb-2''>Filtros Clave</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Dinero:</strong> <code>{{ product.price | money_with_currency }}</code> (Formatea el entero a ej. ''29,99 € EUR'').</li>
                <li><strong>Imágenes:</strong> <code>{{ product.featured_image | image_url: width: 400 }}</code> (Pide al CDN de Shopify que genere y sirva una versión optimizada de 400px en formato WebP dinámicamente).</li>
                <li><strong>Arrays:</strong> <code>map</code>, <code>join</code>, <code>sort</code>, <code>where</code> para extraer y manipular listas complejas de objetos.</li>
            </ul>
        </div>'),
('liquid-bucles', 'Liquid: Iteración', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Manejo de Listas y Paginate</h2>
            <p class=''mb-4''>Para mostrar productos, iteramos sobre colecciones usando bucles <code>for</code>.</p>
            <pre class=''bg-gray-800 text-green-400 p-4 rounded mb-4''><code>
{% paginate collection.products by 12 %}
  {% for product in collection.products %}
    &lt;!-- Render Product Card --&gt;
  {% endfor %}
  {{ paginate | default_pagination }}
{% endpaginate %}
            </code></pre>
            <p><strong>Límite crítico:</strong> Shopify restringe las colecciones a un máximo de 50 elementos devueltos por llamada. Si no envuelves el bucle en un bloque <code>paginate</code>, la página se romperá o solo mostrará los primeros 50.</p>
        </div>'),
('os2-arquitectura', 'Online Store 2.0 (OS 2.0)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>La Nueva Era Temática</h2>
            <p class=''mb-4''>Antes de 2021, solo la página de inicio (Homepage) podía tener bloques arrastrables (Secciones). OS 2.0 cambió la arquitectura: ahora las plantillas no son archivos <code>.liquid</code>, son archivos <code>.json</code> que mapean qué secciones van en qué orden.</p>
            <p>Esto permite a los comerciantes construir páginas completas (Acerca de, FAQ, Landing Pages) usando bloques visuales sin necesitar a un desarrollador para cada pequeño cambio estructural.</p>
        </div>'),
('os2-secciones', 'Desarrollo de Secciones (Sections)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Componentes Reutilizables</h2>
            <p class=''mb-4''>Una sección es un archivo Liquid autónomo. El ''secreto'' es la etiqueta <code>{% schema %}</code>, que define la interfaz en el Theme Editor.</p>
            <pre class=''bg-gray-800 text-yellow-300 p-4 rounded mb-4 text-sm''><code>
{% schema %}
{
  "name": "Hero Banner",
  "settings": [
    { "type": "text", "id": "title", "label": "Título principal" },
    { "type": "image_picker", "id": "bg_image", "label": "Fondo" }
  ]
}
{% endschema %}
            </code></pre>
            <p>Lo que definas en este JSON, aparecerá como controles visuales (cajas de texto, selectores de color) para el administrador de la tienda, y podrás leer esos valores en el HTML usando <code>{{ section.settings.title }}</code>.</p>
        </div>'),
('os2-app-blocks', 'App Blocks y Theme App Extensions', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Ecosistema Limpio</h2>
            <p class=''mb-4''>El mayor problema histórico de Shopify era la desinstalación de Apps. Las apps inyectaban código sucio en los archivos del tema, y al desinstalarse, dejaban ''basura'' que ralentizaba la web.</p>
            <p><strong>Theme App Extensions</strong> resuelven esto. Ahora las apps proveen ''Bloques'' que el usuario arrastra visualmente en el editor. El código de la app vive aislado. Si se desinstala la app, el bloque desaparece automáticamente sin dejar rastro en el código fuente de la tienda.</p>
        </div>'),
('shopify-cli', 'Shopify CLI y Entorno Local', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Herramientas de Desarrollador</h2>
            <p class=''mb-4''>Shopify CLI es un paquete Node.js (se ejecuta en tu terminal con <code>shopify theme dev</code>) que permite:</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li>Crear un túnel seguro (Cloudflare) para ver tu código local ejecutándose contra los datos reales (productos, colecciones) de la base de datos de producción de la tienda.</li>
                <li>Hot-reloading instantáneo de CSS y Liquid en tu navegador mientras programas.</li>
                <li>Desplegar cambios directamente (<code>shopify theme push</code>) sin usar el antiguo y lento Theme Kit.</li>
            </ul>
        </div>'),
('github-integration', 'Integración con GitHub', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>CI/CD Nativo en Shopify</h2>
            <p class=''mb-4''>Puedes conectar un repositorio de GitHub al panel de administración de Shopify. Cada rama (branch) se convertirá en un tema previsualizable oculto en la tienda.</p>
            <p>Cuando un desarrollador hace <code>git push origin main</code>, Shopify detecta el webhook de GitHub y actualiza automáticamente el código del tema principal en milisegundos, permitiendo un flujo de trabajo profesional con Pull Requests y Code Review antes de ir a producción.</p>
        </div>'),
('hydrogen-oxygen', 'Hydrogen y Oxygen (Headless)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Futuro Desacoplado</h2>
            <p class=''mb-4''><strong>Hydrogen</strong> es el stack Headless de Shopify. Basado en <em>Remix</em> (framework de React), permite crear tiendas súper rápidas e interactivas que no usan Liquid en absoluto, leyendo datos directamente de la Storefront API vía GraphQL.</p>
            <p><strong>Oxygen</strong> es la plataforma de hosting global (basada en Workers) construida por Shopify para alojar estas aplicaciones Hydrogen gratuitamente, resolviendo el histórico problema de tener que pagar a Vercel o Netlify para alojar frontends Headless de tiendas Shopify.</p>
        </div>'),
('storefront-api', 'Storefront API (GraphQL)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>La API Pública</h2>
            <p class=''mb-4''>Es un endpoint de GraphQL diseñado para no requerir autenticación de servidor a servidor. Usa un token público.</p>
            <h3 class=''text-xl font-bold mb-2''>¿Para qué se usa?</h3>
            <p>Para construir experiencias de compra fuera del entorno tradicional web: aplicaciones móviles nativas (iOS/Android), integraciones en videojuegos (ej. comprar merchandising sin salir de Fortnite), o para construir un frontend a medida con React, Vue o Svelte.</p>
        </div>'),
('admin-api-rest', 'Admin API (Rest y GraphQL)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Control Total</h2>
            <p class=''mb-4''>Esta API es privada y requiere autenticación segura (Tokens o OAuth). Permite leer, crear y borrar cualquier dato del backend de la tienda (inventario, pedidos, reportes, reembolsos).</p>
            <h3 class=''text-xl font-bold mb-2''>REST vs GraphQL</h3>
            <p>Shopify mantiene su API REST por retrocompatibilidad, pero <strong>GraphQL es obligatorio</strong> para acceder a nuevas funcionalidades (como bulk operations o Metaobjects). GraphQL soluciona el problema de tener que hacer 10 peticiones HTTP (REST) para obtener datos anidados (Over-fetching).</p>
        </div>'),
('webhooks-eventos', 'Webhooks y Eventos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Arquitectura Orientada a Eventos</h2>
            <p class=''mb-4''>Un Webhook permite que tu servidor reciba una notificación (payload JSON) en tiempo real en lugar de tener que consultar la API (polling) constantemente.</p>
            <p><strong>Ejemplo:</strong> Registras el evento <code>orders/create</code>. Cuando un cliente compra, Shopify dispara un POST a tu URL (ej. <code>mi-erp.com/shopify-webhook</code>). Tu servidor lo procesa de inmediato. Es crítico validar el header <code>X-Shopify-Hmac-Sha256</code> para asegurar que el mensaje es realmente de Shopify y no de un hacker.</p>
        </div>'),
('custom-apps', 'Custom Apps', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Desarrollo Privado</h2>
            <p class=''mb-4''>Las Custom Apps se instalan directamente en una tienda específica a través del panel de administración (Settings > Apps and Sales Channels). No requieren revisión pública por parte de Shopify.</p>
            <p>Se usan principalmente para construir conectores B2B a medida, integraciones con sistemas contables locales, o dashboards internos especializados que consumen la Admin API mediante un ''Access Token'' generado permanentemente.</p>
        </div>'),
('public-apps', 'Public Apps y App Store', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Desarrollo SaaS B2B</h2>
            <p class=''mb-4''>Crear una app para vender a miles de comerciantes requiere un nivel técnico mayor.</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>OAuth 2.0:</strong> La instalación requiere redirigir al comerciante, pedir permisos (ej. leer productos) e intercambiar un código por un token de sesión.</li>
                <li><strong>Billing API:</strong> Tienes que integrarte con el motor de cobros de Shopify (cargos recurrentes, freemium) para que Shopify le cobre al comerciante en su factura mensual y luego te transfiera tu parte.</li>
                <li><strong>Proceso de Revisión:</strong> Shopify probará la app exhaustivamente antes de admitirla en la tienda de aplicaciones.</li>
            </ul>
        </div>'),
('shopify-flow', 'Shopify Flow (Automatizaciones)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>No-Code Logic</h2>
            <p class=''mb-4''>Shopify Flow es un constructor visual de lógicas empresariales. Sigue la estructura: <strong>Trigger</strong> (Disparador), <strong>Condition</strong> (Condición), <strong>Action</strong> (Acción).</p>
            <p><strong>Ejemplos Reales:</strong></p>
            <ul class=''list-disc pl-5 mb-4''>
                <li>Si el stock de un producto baja de 10 unidades -> Enviar Slack a Compras y pausar anuncios en Google Ads.</li>
                <li>Si un pedido es marcado como ''Alto riesgo de Fraude'' -> Cancelar pedido, hacer reembolso automático, y etiquetar al cliente como bloqueado.</li>
            </ul>
            <p>Los desarrolladores pueden construir conectores (App Actions) para que Flow pueda integrarse con sus propias aplicaciones.</p>
        </div>'),
('shopify-functions', 'Shopify Functions (WASM/Rust)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Extensibilidad del Backend</h2>
            <p class=''mb-4''>Las Functions reemplazan a los antiguos <em>Shopify Scripts</em>. Permiten ejecutar código personalizado a nivel de servidor <strong>dentro</strong> de la infraestructura hiper-rápida de Shopify.</p>
            <p>Los programadores escriben la lógica de descuentos complejos o reglas logísticas en <strong>Rust, C++ o Javascript (Javy)</strong>, lo compilan a WebAssembly (WASM) y lo suben. Estas funciones se ejecutan en milisegundos durante el checkout sin introducir latencia, solucionando necesidades complejas de descuentos (ej. "3x2 si el producto es de esta marca y el usuario es VIP tier 2").</p>
        </div>'),
('pixels-tracking', 'Web Pixel Manager y Tracking', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Seguridad en la Analítica</h2>
            <p class=''mb-4''>Históricamente, los píxeles de Facebook, Google y TikTok se inyectaban en el <code>theme.liquid</code>, accediendo indiscriminadamente a todo el DOM y comprometiendo el rendimiento y la privacidad.</p>
            <p>Shopify introdujo una API unificada (Customer Events). Los píxeles corren en un <strong>entorno Web Worker aislado (Sandbox)</strong>. Ya no pueden acceder a la página web real, sino que se suscriben a eventos emitidos por Shopify de forma estandarizada (<code>checkout_completed</code>, <code>product_viewed</code>), aumentando la velocidad de carga de la web y el cumplimiento de leyes como la RGPD.</p>
        </div>'),
('optimizacion-rendimiento', 'Optimización de Rendimiento', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Core Web Vitals</h2>
            <p class=''mb-4''>La velocidad impacta directamente al SEO y la conversión. Las responsabilidades de un desarrollador Shopify experto incluyen:</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>LCP (Largest Contentful Paint):</strong> Precargar (<code>preload</code>) la imagen principal del producto y desactivar el ''lazy loading'' en el LCP.</li>
                <li><strong>CLS (Cumulative Layout Shift):</strong> Definir siempre <code>width</code> y <code>height</code> de las imágenes (usando el atributo <code>aspect-ratio</code> de CSS) para reservar el espacio antes de que carguen.</li>
                <li><strong>Limpieza de Apps:</strong> Evaluar impactos y desactivar scripts sobrantes.</li>
            </ul>
        </div>'),
('seguridad-fraude', 'Seguridad y Análisis de Fraude', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Protección contra Chargebacks</h2>
            <p class=''mb-4''>Los fraudes en tarjetas de crédito son el mayor agujero económico del comercio B2C. Shopify integra un motor de análisis de fraude automático usando Machine Learning.</p>
            <p>Verifica disparidades como que la IP sea de Rusia, pero la dirección de entrega en España, o que el CVV esté ausente pero la transacción haya pasado (común en robos masivos de tarjetas). Un comerciante o un script de automatización pueden decidir rechazar estos pagos antes de enviarlos, previniendo así un ''Chargeback'' del banco que conlleva tarifas punitivas de 15$ a 30$.</p>
        </div>');


-- Insert Questions
INSERT INTO questions (question_text, option_0, option_1, option_2, option_3, correct_answer_index, xp_reward, module_slug) VALUES
('¿Qué lenguaje de plantillas utiliza Shopify para sus temas?', 'PHP', 'Liquid', 'Jinja', 'Blade', 1, 10, 'liquid-sintaxis'),
('¿Qué símbolo se usa en Liquid para mostrar la salida de una variable (Output)?', '{% %}', '[[ ]]', '{{ }}', '<?php ?>', 2, 10, 'liquid-sintaxis'),
('¿Qué hace el carácter de tubería "|" en Liquid?', 'Cierra un bloque if', 'Aplica un filtro a una variable', 'Concatena strings', 'Comenta código', 1, 10, 'liquid-sintaxis'),
('¿Cómo se comenta código en Liquid?', '{# comentario #}', '<!-- comentario -->', '{% comment %} comentario {% endcomment %}', '// comentario', 2, 10, 'liquid-sintaxis'),
('¿Cuál es el objeto global en Liquid que contiene la información de la tienda?', 'store', 'shop', 'global', 'settings', 1, 10, 'liquid-sintaxis'),
('¿Qué etiqueta se usa para iterar sobre una colección de productos en Liquid?', '{% loop %}', '{% foreach %}', '{% for %}', '{% iterate %}', 2, 10, 'liquid-sintaxis'),
('¿Cómo se asigna un valor a una variable en Liquid?', '{% set var = ''valor'' %}', '{% assign var = ''valor'' %}', '{{ var = ''valor'' }}', '{% let var = ''valor'' %}', 1, 10, 'liquid-sintaxis'),
('¿Qué filtro se usa para convertir un texto a mayúsculas en Liquid?', 'upcase', 'upper', 'capitalize', 'uppercase', 0, 10, 'liquid-sintaxis'),
('¿Cómo capturas un bloque de texto en una variable en Liquid?', '{% capture var %}...{% endcapture %}', '{% assign block var %}...{% endassign %}', '{% block var %}...{% endblock %}', '{% save var %}...{% endsave %}', 0, 15, 'liquid-sintaxis'),
('¿Qué hace el tag {% include %} en Liquid (obsoleto)?', 'Importa una librería de JS', 'Inserta un snippet', 'Incluye una app de terceros', 'Carga un producto', 1, 15, 'liquid-sintaxis'),
('¿Qué tag se recomienda usar en lugar de {% include %} en versiones modernas de Shopify?', '{% insert %}', '{% require %}', '{% render %}', '{% snippet %}', 2, 15, 'liquid-sintaxis'),
('¿Cuál de estos es un tipo de dato válido en Liquid?', 'Array', 'String', 'Number', 'Todos los anteriores', 3, 10, 'liquid-sintaxis'),
('¿Cómo verificas si una variable está vacía en Liquid?', '{% if var == empty %}', '{% if var == blank %}', '{% if var == null %}', '{% if var == '''' %}', 1, 15, 'liquid-sintaxis'),
('¿Qué filtro se usa para dar formato de dinero a un número en Liquid?', 'money', 'currency', 'format_money', 'price', 0, 10, 'liquid-sintaxis'),
('¿Qué objeto Liquid se usa para acceder a los ajustes del tema?', 'theme.settings', 'settings', 'shop.theme', 'configuration', 1, 15, 'liquid-sintaxis'),
('¿Qué hace el operador ''contains'' en Liquid?', 'Suma dos variables', 'Comprueba si un string o array incluye una subcadena o elemento', 'Comprueba si una variable existe', 'Concatena strings', 1, 15, 'liquid-sintaxis'),
('Si quieres mostrar los primeros 3 productos de una colección, ¿qué filtro o parámetro usas en el for?', '{% for p in collection limit:3 %}', '{% for p in collection max:3 %}', '{% for p in collection stop:3 %}', '{% for p in collection first:3 %}', 0, 15, 'liquid-sintaxis'),
('¿Qué es ''paginate'' en Liquid?', 'Un filtro para cortar texto', 'Un bloque para dividir grandes colecciones de productos en múltiples páginas', 'Un objeto de orden', 'Un tipo de menú', 1, 15, 'liquid-sintaxis'),
('¿Qué hace el filtro ''default''?', 'Establece un valor por defecto si la variable está vacía o no existe', 'Elimina la variable', 'Muestra un error', 'Convierte la variable a string', 0, 10, 'liquid-sintaxis'),
('¿Cómo se escribe un bloque ''else if'' en Liquid?', '{% elseif %}', '{% else if %}', '{% elsif %}', '{% elif %}', 2, 15, 'liquid-sintaxis'),
('¿Qué filtro usarías para convertir una fecha a un formato legible?', 'time', 'date', 'format_date', 'strftime', 1, 10, 'liquid-sintaxis'),
('¿Qué devuelve el filtro ''handleize''?', 'Convierte un texto en un formato amigable para URL (minúsculas, guiones)', 'Crea un producto nuevo', 'Devuelve el ID', 'Borra los espacios', 0, 15, 'liquid-sintaxis'),
('¿Cómo obtienes el primer elemento de un array en Liquid?', 'array.0', 'array[1]', 'array.first', 'first(array)', 2, 10, 'liquid-sintaxis'),
('¿Qué hace el filtro ''strip_html''?', 'Añade etiquetas HTML', 'Borra todo el texto', 'Elimina todas las etiquetas HTML de un string', 'Convierte texto a HTML', 2, 10, 'liquid-sintaxis'),
('¿Qué hace el filtro ''where'' en Liquid?', 'Crea una consulta SQL', 'Filtra un array de objetos según el valor de una propiedad', 'Busca en Google', 'Redirige a otra página', 1, 15, 'liquid-sintaxis'),
('¿Qué hace el filtro ''map'' en Liquid?', 'Muestra un mapa de Google', 'Extrae una propiedad específica de todos los objetos en un array (ej. extraer solo los títulos)', 'Ubica la tienda', 'Convierte un string a un array', 1, 15, 'liquid-sintaxis'),

('¿Qué es un SKU en la gestión de inventario?', 'Una pasarela de pago', 'Un código de barras universal', 'Una unidad de seguimiento de stock', 'Un impuesto', 2, 10, 'productos-variantes'),
('¿Cuántas opciones (ej. Talla, Color) permite Shopify por defecto por producto?', '1', '2', '3', 'Ilimitadas', 2, 15, 'productos-variantes'),
('¿Cuántas variantes en total puede tener un producto en Shopify por defecto?', '50', '100', '200', '500', 1, 15, 'productos-variantes'),
('Si un producto tiene 3 colores y 4 tallas, ¿cuántas variantes se crean?', '7', '12', '3', '4', 1, 10, 'productos-variantes'),
('¿Qué objeto en Liquid representa una variante individual de un producto?', 'product.variant', 'variant', 'product.options', 'item.variant', 1, 15, 'productos-variantes'),
('¿Qué indica la propiedad variant.inventory_quantity?', 'El precio de la variante', 'El peso de la variante', 'La cantidad en stock de la variante', 'El número de SKU', 2, 10, 'productos-variantes'),
('¿Qué significa ''Continuar vendiendo cuando esté agotado'' en Shopify?', 'Que el producto se oculta', 'Que los clientes pueden hacer pre-pedidos sin stock', 'Que el precio cambia a 0', 'Que se desactiva el SKU', 1, 10, 'productos-variantes'),
('¿Qué es un ''Vendor'' en un producto de Shopify?', 'El precio de coste', 'La marca o proveedor del producto', 'El tipo de producto', 'El peso para el envío', 1, 10, 'productos-variantes'),
('¿Para qué se utilizan los ''Tags'' (Etiquetas) en los productos?', 'Para organizar y filtrar productos', 'Para definir el precio', 'Para asignar el stock', 'Para crear el SKU', 0, 10, 'productos-variantes'),
('¿Qué formato de imagen recomienda Shopify para productos?', 'BMP', 'TIFF', 'WebP o JPEG', 'SVG', 2, 10, 'productos-variantes'),
('¿Qué es una colección ''Automatizada'' en Shopify?', 'Una colección que los clientes crean', 'Una colección que añade productos basados en condiciones', 'Una colección que cambia de precio', 'Una colección vacía', 1, 10, 'productos-variantes'),
('¿Qué objeto de Liquid representa una colección?', 'category', 'collection', 'group', 'product_list', 1, 10, 'productos-variantes'),
('¿Cómo accedes a todos los productos de una colección en Liquid?', 'collection.items', 'collection.all', 'collection.products', 'collection.list', 2, 10, 'productos-variantes'),
('¿Qué límite de productos tiene Shopify en sus planes estándar?', '100', '10,000', '100,000', 'No hay límite estricto de productos', 3, 10, 'productos-variantes'),
('¿Qué son las ''Ubicaciones'' (Locations) en Shopify?', 'Los idiomas de la tienda', 'Lugares físicos o apps donde se gestiona inventario y se preparan pedidos', 'Las direcciones de los clientes', 'Las zonas de envío', 1, 10, 'productos-variantes'),

('En el plan estándar de Shopify, ¿qué parte del checkout puedes modificar usando código HTML/CSS libremente?', 'Todo el checkout', 'Solo la cabecera', 'Ninguna parte, solo estilos visuales desde el editor', 'El botón de pago', 2, 15, 'checkout-configuracion'),
('¿Qué plan de Shopify permite modificar el checkout extensivamente (Checkout Extensibility)?', 'Shopify Basic', 'Shopify Plan', 'Advanced Shopify', 'Shopify Plus', 3, 20, 'checkout-configuracion'),
('¿Dónde configuras si el número de teléfono es obligatorio en el checkout?', 'En la configuración de Envíos', 'En la configuración de Pantalla de pago', 'En el editor de temas', 'En la configuración de Impuestos', 1, 10, 'checkout-configuracion'),
('¿Qué es un carrito abandonado?', 'Un pedido reembolsado', 'Un usuario que añade productos pero no completa el pago', 'Un producto sin stock', 'Una devolución', 1, 10, 'checkout-configuracion'),
('¿Puede Shopify enviar correos automáticos de carritos abandonados?', 'Sí, está integrado de forma nativa', 'No, necesitas una app de terceros', 'Solo en Shopify Plus', 'Solo si el cliente ya ha comprado antes', 0, 15, 'checkout-configuracion'),
('¿Qué estado tiene un pedido cuando el pago fue exitoso pero no se ha enviado?', 'Completado', 'Pendiente de pago', 'No preparado (Unfulfilled)', 'Archivado', 2, 15, 'checkout-configuracion'),
('¿Qué es el ''Fulfillment'' en Shopify?', 'El proceso de preparar y enviar el pedido', 'El reembolso del pedido', 'El pago del pedido', 'La creación de un producto', 0, 10, 'checkout-configuracion'),
('¿Qué objeto de Liquid se usa en la página del carrito?', 'cart', 'basket', 'order', 'checkout', 0, 10, 'checkout-configuracion'),
('¿Cómo iteras sobre los artículos del carrito en Liquid?', '{% for item in cart.items %}', '{% for product in cart.products %}', '{% for line in cart.lines %}', '{% for item in checkout.items %}', 0, 15, 'checkout-configuracion'),
('¿Qué hace cart.total_price?', 'Devuelve el peso total', 'Devuelve el precio total en formato moneda', 'Devuelve el precio total en centavos', 'Devuelve los impuestos', 2, 15, 'checkout-configuracion'),
('¿Qué es Shopify Payments?', 'Una app de terceros', 'La pasarela de pago nativa de Shopify', 'Un método de envío', 'Un plan de suscripción', 1, 10, 'checkout-configuracion'),
('Si usas una pasarela de pago externa en lugar de Shopify Payments, ¿qué ocurre?', 'Shopify no te deja vender', 'Shopify te cobra una comisión adicional por transacción', 'Es gratis', 'Solo puedes vender en tu país', 1, 20, 'checkout-configuracion'),

('¿Qué es Online Store 2.0 (OS 2.0)?', 'La segunda versión de Shopify', 'La nueva arquitectura de temas que permite bloques y secciones en todas las páginas', 'Una actualización de precios', 'Un nuevo tema predeterminado', 1, 15, 'os2-arquitectura'),
('En OS 2.0, ¿qué formato de archivo se usa para las plantillas principales (ej. product)?', '.liquid', '.html', '.json', '.xml', 2, 20, 'os2-arquitectura'),
('¿Qué es una ''Sección'' en un tema de Shopify?', 'Un bloque de código reutilizable que puede ser configurado en el editor de temas', 'Un producto', 'Un artículo del blog', 'Una pasarela de pago', 0, 10, 'os2-arquitectura'),
('En el esquema de una sección {% schema %}, ¿qué lenguaje se utiliza?', 'XML', 'YAML', 'JSON', 'Markdown', 2, 15, 'os2-arquitectura'),
('¿Cómo incluyes una sección estática en Liquid?', '{% include ''header'' %}', '{% section ''header'' %}', '{% require ''header'' %}', '{% load ''header'' %}', 1, 15, 'os2-arquitectura'),
('¿Qué hace la carpeta ''assets'' en un tema de Shopify?', 'Guarda los productos', 'Guarda los pedidos', 'Almacena CSS, JS e imágenes del tema', 'Guarda los clientes', 2, 10, 'os2-arquitectura'),
('¿Qué hace el filtro | asset_url?', 'Genera la URL de un producto', 'Devuelve la URL de una imagen en la carpeta assets en el CDN', 'Redirige al inicio', 'Crea un enlace de pago', 1, 10, 'os2-arquitectura'),
('¿Para qué sirve la carpeta ''locales'' en un tema?', 'Para almacenar direcciones IP', 'Para archivos JSON de traducciones (multidioma)', 'Para guardar ubicaciones físicas de la tienda', 'Para guardar monedas', 1, 15, 'os2-arquitectura'),
('¿Qué es un ''Snippet'' en Shopify?', 'Un pequeño fragmento de código Liquid reutilizable', 'Una imagen pequeña', 'Un descuento temporal', 'Una variante de producto', 0, 10, 'os2-arquitectura'),
('¿En qué carpeta se guardan los snippets?', 'templates/', 'sections/', 'snippets/', 'assets/', 2, 10, 'os2-arquitectura'),
('¿Qué son los App Blocks en OS 2.0?', 'Bloques de construcción de plástico', 'Permiten a las apps inyectar código visualmente en el tema sin modificar los archivos Liquid directamente', 'Bloqueadores de anuncios', 'Apps que bloquean fraudes', 1, 20, 'os2-arquitectura'),

('¿Qué es un ''Metafield'' en Shopify?', 'Un campo personalizado para añadir información extra a productos, clientes o pedidos', 'Un campo de fuerza', 'Una etiqueta HTML', 'Una regla de envío', 0, 15, 'intro-ecommerce'),
('¿Dónde modificas el Título SEO de un producto en Shopify?', 'En la configuración general', 'Al final de la página de edición del producto (Buscadores)', 'En el tema Liquid exclusivamente', 'En la pasarela de pago', 1, 10, 'intro-ecommerce'),
('¿Qué genera Shopify automáticamente para el SEO?', 'Sitemap.xml y robots.txt', 'Páginas de Wikipedia', 'Cuentas de Instagram', 'Artículos de blog', 0, 15, 'intro-ecommerce'),
('¿Puedes cambiar la estructura de la URL base de un producto (ej. /products/mi-producto)?', 'Sí, completamente', 'No, el prefijo /products/ es fijo en Shopify', 'Solo en Shopify Plus', 'Solo instalando una App', 1, 20, 'intro-ecommerce'),
('¿Qué es un código de descuento automático?', 'Un código que el cliente debe escribir a mano', 'Un descuento que se aplica solo en el carrito si se cumplen las condiciones', 'Un descuento falso', 'Una tarjeta de regalo', 1, 10, 'intro-ecommerce'),
('¿Qué es una tarjeta de regalo (Gift Card) en Shopify?', 'Un producto físico que se envía por correo', 'Un producto especial cuyo valor se puede usar como método de pago', 'Un cupón de descuento de porcentaje', 'Una forma de donar a ONGs', 1, 10, 'intro-ecommerce'),
('¿Shopify incluye un sistema de blog integrado?', 'Sí', 'No', 'Solo mediante apps', 'Solo en el plan avanzado', 0, 10, 'intro-ecommerce'),
('¿Qué es el objeto ''linklist'' en Liquid?', 'Una lista de productos', 'Un menú de navegación', 'Una lista de clientes', 'Los enlaces de redes sociales', 1, 15, 'intro-ecommerce'),
('¿Qué información guarda Shopify sobre un cliente?', 'Historial de pedidos, direcciones, nombre y email', 'Contraseña en texto plano', 'Datos de tarjeta de crédito completos', 'Su historial de navegación', 0, 10, 'intro-ecommerce'),
('¿Qué son los ''Tags'' de cliente?', 'Etiquetas para segmentar clientes (ej. VIP, Mayorista)', 'Nombres de usuario', 'Las contraseñas cifradas', 'Los productos que ha comprado', 0, 10, 'intro-ecommerce'),
('¿Dónde descargas aplicaciones oficiales para Shopify?', 'Google Play', 'App Store de Apple', 'Shopify App Store', 'En el editor de temas', 2, 10, 'intro-ecommerce'),
('¿Qué es una ''Custom App'' (App Personalizada) en Shopify?', 'Una app que está en la App Store', 'Una app desarrollada específicamente para una tienda y que no se publica en la App Store', 'Una app de diseño visual', 'Un tema a medida', 1, 15, 'intro-ecommerce'),
('¿Qué es Shopify CLI?', 'Una interfaz de línea de comandos para construir temas y apps de Shopify rápidamente', 'Un lenguaje de programación', 'Una pasarela de pago', 'Un tema gratuito', 0, 15, 'intro-ecommerce'),
('¿En qué lenguaje está escrito el núcleo del backend de Shopify?', 'PHP', 'Node.js', 'Ruby on Rails', 'Java', 2, 20, 'intro-ecommerce'),
('¿Qué tipo de plataforma es Shopify?', 'IaaS', 'SaaS (Software as a Service)', 'Open Source descargable', 'Un plugin de WordPress', 1, 10, 'intro-ecommerce'),
('¿Qué es Shopify POS?', 'Point of Sale, un sistema para vender en tiendas físicas sincronizado con la tienda online', 'Un tipo de producto', 'Un impuesto sobre ventas', 'Position of Store', 0, 10, 'intro-ecommerce'),
('¿Qué es un ''Redirect'' (Redireccionamiento) en Shopify?', 'Un cambio de color', 'Una regla para enviar a los usuarios de una URL antigua a una nueva (ej. error 404 a otra página)', 'Un reembolso automático', 'Un código de envío gratis', 1, 10, 'intro-ecommerce');


-- New Questions for all 50 modules
INSERT INTO questions (question_text, option_0, option_1, option_2, option_3, correct_answer_index, xp_reward, module_slug) VALUES
('¿Qué significa que Shopify sea una plataforma SaaS?', 'Software as a Service', 'System as a Service', 'Service as a System', 'Software and System', 0, 20, 'intro-ecommerce'),
('¿Cuál es el motor de base de datos principal que usa Shopify?', 'MySQL', 'PostgreSQL', 'MongoDB', 'Oracle', 0, 20, 'arquitectura-shopify'),
('¿Qué plan de Shopify es el nivel Enterprise?', 'Shopify Plus', 'Advanced Shopify', 'Basic Shopify', 'Starter', 0, 20, 'planes-precios'),
('¿En qué sección del admin se configuran los prefijos de pedido?', 'Información de la tienda', 'Pantalla de pago', 'Envíos', 'Mercados', 0, 20, 'configuracion-inicial'),
('¿A qué IP debe apuntar el registro A de un dominio de terceros?', '23.227.38.65', '127.0.0.1', '1.1.1.1', '8.8.8.8', 0, 20, 'gestion-dominios'),
('¿Cuál es el límite máximo de variantes por producto en Shopify estándar?', '50', '100', '200', '500', 1, 20, 'productos-variantes'),
('¿Qué característica es exclusiva de las colecciones manuales?', 'Ordenación personalizada drag-and-drop', 'Uso de etiquetas para filtrar', 'Filtros por precio', 'Sincronización con Google', 0, 20, 'colecciones-manuales'),
('¿Qué operador lógico se usa para requerir que se cumplan TODAS las condiciones?', 'AND', 'OR', 'XOR', 'NOT', 0, 20, 'colecciones-automatizadas'),
('¿Cómo se llaman los lugares físicos en Shopify donde rastreas stock?', 'Locations (Ubicaciones)', 'Warehouses', 'Stores', 'Puntos de venta', 0, 20, 'inventario-ubicaciones'),
('¿Cuál es el límite máximo de tags recomendado por producto?', '250', '100', '500', '1000', 0, 20, 'etiquetas-tags'),
('¿Qué tres elementos componen la estructura de un Metafield?', 'Namespace, Key y Value', 'Title, Slug y Body', 'ID, Name y Date', 'Tag, Category y Price', 0, 20, 'metafields-intro'),
('¿Qué ventaja ofrecen los Metaobjects sobre los Metafields?', 'Pueden generar páginas dinámicas propias', 'Son más baratos', 'No requieren API', 'Solo funcionan en Plus', 0, 20, 'metaobjects-intro'),
('¿Qué lenguaje se usa para crear segmentos dinámicos de clientes?', 'ShopifyQL', 'SQL', 'Javascript', 'Python', 0, 20, 'clientes-segmentacion'),
('¿Qué funcionalidad es clave en el modelo B2B de Shopify?', 'Catálogos de precios específicos', 'Venta por Instagram', 'Envío gratis siempre', 'Chat en vivo', 0, 20, 'b2b-shopify'),
('¿Qué app nativa de Shopify acelera el checkout en 1 clic?', 'Shop App', 'Facebook Channel', 'Google Channel', 'Messenger', 0, 20, 'canales-venta'),
('¿Qué dispositivo propio de Shopify permite vender en físico?', 'POS Go', 'Shopify Watch', 'Shopify Phone', 'Shopify Tablet', 0, 20, 'shopify-pos'),
('¿Qué estado financiero indica que los fondos están retenidos pero no cobrados?', 'Authorized', 'Paid', 'Pending', 'Voided', 0, 20, 'pedidos-fulfillment'),
('¿Qué es una RMA?', 'Autorización de devolución de mercancía', 'Regla de marketing avanzado', 'Registro de marca asociado', 'Recibo de monto anual', 0, 20, 'devoluciones-reembolsos'),
('¿Cómo permite Markets manejar múltiples países en una tienda?', 'Dominios y subcarpetas específicas', 'Varias bases de datos', 'Cuentas de hosting separadas', 'Apps de traducción externas solamente', 0, 20, 'shopify-markets'),
('¿Qué es el ''Nexus'' en el contexto de impuestos de EE.UU.?', 'Presencia física o económica en un estado', 'Una conexión de internet', 'Un modelo de datos', 'Un puerto de red', 0, 20, 'impuestos-taxes'),
('¿Para qué sirven los perfiles de envío?', 'Agrupar productos con tarifas diferentes', 'Crear perfiles de usuario', 'Sincronizar con redes sociales', 'Configurar el logo de la empresa', 0, 20, 'envios-zonas'),
('¿Qué pasarela nativa evita comisiones adicionales por transacción?', 'Shopify Payments', 'PayPal', 'Stripe', 'Authorize.net', 0, 20, 'pasarelas-pago'),
('¿Qué se puede configurar nativamente en el checkout estándar?', 'Logo, colores y fuentes', 'Código HTML libre', 'Scripts de seguimiento PHP', 'Nuevos pasos de pago', 0, 20, 'checkout-configuracion'),
('¿En qué lenguaje se construyen las Checkout UI Extensions?', 'React (Javascript)', 'Liquid', 'Ruby', 'PHP', 0, 20, 'checkout-extensibility'),
('¿Qué novedad permite Shopify con los descuentos recientemente?', 'Combinar múltiples tipos de descuentos', 'Descuentos de 200%', 'Solo 1 descuento por vida', 'Descuentos que pagan al cliente', 0, 20, 'descuentos-cupones'),
('¿Por qué son mejores los descuentos automáticos para la conversión?', 'Eliminan la fricción de buscar códigos', 'Son más caros', 'Requieren más pasos', 'Solo funcionan en móvil', 0, 20, 'descuentos-automaticos'),
('¿Cómo se consideran las Gift Cards contablemente antes de ser canjeadas?', 'Pasivo diferido', 'Activo circulante', 'Gasto de marketing', 'Ingreso neto', 0, 20, 'tarjetas-regalo'),
('¿Cuál es el flujo de email marketing más crítico?', 'Carrito abandonado', 'Bienvenida', 'Cumpleaños', 'Newsletter semanal', 0, 20, 'marketing-basico'),
('¿Qué archivos SEO genera Shopify automáticamente?', 'sitemap.xml y robots.txt', 'index.html', 'style.css', 'script.js', 0, 20, 'seo-basico'),
('¿Cuál es el código HTTP para una redirección permanente?', '301', '404', '200', '500', 0, 20, 'redirecciones-301'),
('¿Qué mide la Tasa de Conversión (CR)?', '% de sesiones que acaban en compra', 'Número de visitas', 'Velocidad de la web', 'Seguidores en Instagram', 0, 20, 'analitica-reportes'),
('¿Quién creó originalmente el lenguaje Liquid?', 'Shopify', 'Wordpress', 'Adobe', 'Microsoft', 0, 20, 'liquid-sintaxis'),
('¿Qué filtro se usa para optimizar imágenes en el CDN?', 'image_url', 'img_src', 'resize', 'crop', 0, 20, 'liquid-filtros'),
('¿Cuál es el límite de elementos de un bucle ''for'' sin paginación?', '50', '100', '500', '1000', 0, 20, 'liquid-bucles'),
('¿En qué formato están las plantillas en OS 2.0?', 'JSON', 'Liquid', 'HTML', 'XML', 0, 20, 'os2-arquitectura'),
('¿Qué tag de Liquid define el editor visual de una sección?', '{% schema %}', '{% section %}', '{% settings %}', '{% design %}', 0, 20, 'os2-secciones'),
('¿Qué ventaja tienen los App Blocks?', 'No dejan basura al desinstalar la app', 'Son más rápidos que Liquid', 'Hacen que la app sea gratis', 'Solo funcionan en PC', 0, 20, 'os2-app-blocks'),
('¿Qué comando inicia el desarrollo local de temas?', 'shopify theme dev', 'shopify theme start', 'shopify theme push', 'shopify theme pull', 0, 20, 'shopify-cli'),
('¿Qué ocurre al hacer ''git push'' en una rama conectada?', 'Shopify actualiza el tema automáticamente', 'Se borra la tienda', 'Nada, es manual', 'Se envía un email al soporte', 0, 20, 'github-integration'),
('¿Qué framework usa Hydrogen?', 'Remix (React)', 'Next.js', 'Vue.js', 'Angular', 0, 20, 'hydrogen-oxygen'),
('¿Qué tecnología usa la Storefront API?', 'GraphQL', 'REST', 'SOAP', 'Websockets', 0, 20, 'storefront-api'),
('¿Por qué GraphQL es preferible a REST en Shopify?', 'Evita el Over-fetching de datos', 'Es más antiguo', 'Solo funciona en PHP', 'No requiere tokens', 0, 20, 'admin-api-rest'),
('¿Qué header se usa para validar la autenticidad de un webhook?', 'X-Shopify-Hmac-Sha256', 'X-Auth-Token', 'Content-Type', 'User-Agent', 0, 20, 'webhooks-eventos'),
('¿Dónde se instalan las Custom Apps?', 'Directamente en el admin de una tienda', 'En la App Store pública', 'En Google Play', 'No se instalan', 0, 20, 'custom-apps'),
('¿Qué API se usa para cobrar a los comerciantes en apps públicas?', 'Billing API', 'Payment API', 'Transaction API', 'Money API', 0, 20, 'public-apps'),
('¿Cuál es la estructura de una automatización en Flow?', 'Trigger -> Condition -> Action', 'Start -> Stop -> End', 'Input -> Process -> Output', 'Do -> While -> Repeat', 0, 20, 'shopify-flow'),
('¿En qué se compilan las Shopify Functions?', 'WebAssembly (WASM)', 'Javascript', 'Python', 'C#', 0, 20, 'shopify-functions'),
('¿Dónde se ejecutan los nuevos píxeles de tracking?', 'En un Sandbox aislado (Web Worker)', 'Directamente en el DOM', 'En el servidor', 'En la base de datos', 0, 20, 'pixels-tracking'),
('¿Qué mide el LCP?', 'El tiempo de carga del elemento visual más grande', 'El número de imágenes', 'El tamaño del JS', 'El retraso del primer clic', 0, 20, 'optimizacion-rendimiento'),
('¿Qué previene el análisis de fraude nativo?', 'Chargebacks (Contracargos)', 'Caídas del servidor', 'Virus', 'Spam en comentarios', 0, 20, 'seguridad-fraude');
