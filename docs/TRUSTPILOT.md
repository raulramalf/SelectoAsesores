# Opiniones de Trustpilot

La web ya está preparada: en Inicio aparece la sección «Opiniones verificadas» en cuanto se
rellenan estos datos en el `.env`. Mientras estén vacíos, la sección no se muestra.

1. Crea (o reclama) el perfil de empresa en https://business.trustpilot.com.
2. Invita a tus clientes a valorar desde Trustpilot (ellos mismos escriben la opinión; no se
   pueden escribir ni editar desde la web).
3. En Trustpilot Business: **Integraciones → TrustBoxes**. Elige una plantilla (por ejemplo
   «Carousel» para ver opiniones, o «Micro TrustScore» para una puntuación compacta) y copia:
   - `data-businessunit-id` → `VITE_TRUSTPILOT_BUSINESS_ID`
   - `data-template-id` → `VITE_TRUSTPILOT_TEMPLATE_ID`
   - `data-token` (solo si la plantilla lo incluye) → `VITE_TRUSTPILOT_TOKEN`
   - La dirección de tu perfil (https://es.trustpilot.com/review/...) → `VITE_TRUSTPILOT_URL`
4. Pon esos valores en `.env` y **vuelve a compilar** (`npm run build`): son variables de
   compilación, no se leen en caliente.

## Cookies y privacidad
El widget de Trustpilot es un servicio de terceros. Por eso no se carga solo: el visitante pulsa
«Mostrar opiniones». La Política de Cookies actual dice que solo se usan cookies estrictamente
necesarias; conviene actualizarla para mencionar Trustpilot (consúltalo con tu asesor legal).
