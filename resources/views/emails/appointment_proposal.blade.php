@component('mail::message')
# Hola {{ $nombreCliente }},

Se ha generado una nueva propuesta de cita en nuestro sistema para gestionar tu solicitud.

@component('mail::button', ['url' => URL::signedRoute('appointment.confirm', ['token' => $appointment->token])])
Confirmar Cita
@endcomponent

Gracias,<br>
{{ config('app.name') }}
@endcomponent