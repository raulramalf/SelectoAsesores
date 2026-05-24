<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Document;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class DocumentController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'user_id'     => ['required', 'exists:users,id'],
            'name'        => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string', 'max:500'],
            'type'        => ['required', 'in:declaracion,contrato,factura,informe,otro'],
            'file'        => ['required', 'file', 'max:10240', 'mimes:pdf,docx,txt,jpg,jpeg,png'],
        ]);

        $path = $request->file('file')->store('documentos', 'public');

        Document::create([
            'user_id'     => $request->user_id,
            'name'        => $request->name,
            'description' => $request->description,
            'type'        => $request->type,
            'url'         => $path,
            'size'        => $request->file('file')->getSize(),
            'uploaded_by' => Auth::user()->name,
        ]);

        return redirect()->back()->with('flash', ['status' => 'documento-subido']);
    }

    public function destroy(string $id)
    {
        $doc = Document::findOrFail($id);

        if ($doc->url && Storage::disk('public')->exists($doc->url)) {
            Storage::disk('public')->delete($doc->url);
        }

        $doc->delete();

        return redirect()->back()->with('flash', ['status' => 'documento-eliminado']);
    }
}