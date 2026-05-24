<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AppointmentProposalMail extends Mailable
{
    use Queueable, SerializesModels;

    public $appointment;
    public $nombreCliente; 

    public function __construct($appointment, $nombreCliente)
    {
        $this->appointment = $appointment;
        $this->nombreCliente = $nombreCliente; 
    }

    public function build()
    {
        return $this->subject('Propuesta de Cita - Selecto Asesores')
                    ->markdown('emails.appointment_proposal'); 
    }
}