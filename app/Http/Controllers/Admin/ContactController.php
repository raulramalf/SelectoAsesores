<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Contact; 
use Illuminate\Http\Request;

class ContactController extends Controller
{
    
    public function destroy($id)
{
    $message = \App\Models\ContactMessage::findOrFail($id);
    $message->delete();

    return redirect()->back();
}
}