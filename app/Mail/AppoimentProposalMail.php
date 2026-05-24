<?php
namespace App\Mail;
use Illuminate\Mail\Mailable;

class AppointmentProposalMail extends Mailable {
    public $appointment;
    public $url;

    public function __construct($appointment, $url) {
        $this->appointment = $appointment;
        $this->url = $url;
    }

    public function build() {
        return $this->subject('Propuesta de Cita - Selecto Asesores')
                    ->view('emails.appointment_proposal');
    }
}