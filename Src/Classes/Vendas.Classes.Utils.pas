unit Vendas.Classes.Utils;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms;
Type
  TUtilsRotinas = class
  public
    class function ValidaCPF(const ACPF: string): Boolean;
    class function ValidaCNPJ(const ACNPJ: string): Boolean;
  end;

implementation

{ TUtilsRotinas }

class function TUtilsRotinas.ValidaCNPJ(const ACNPJ: string): Boolean;
var i, soma, peso, divisor, digito: integer;
begin
  result := false;

  if (Length(ACNPJ) <> 14) then //Verifica se o ACNPJ contem os 14 digitos
  begin
    Application.MessageBox('CNPJ Inválido, informe todos os números',
      'Validador CNPJ', MB_ICONWARNING);
    exit;
  end;

  //Verificando o digito 13
  soma := 0;
  peso := 5;

  for i := 1 to 12 do
  begin
    soma := soma + (StrToInt(ACNPJ[i]) * peso);
    dec(peso); //ou peso := peso - 1;
    if (peso = 1) then peso := 9;//Altera o peso para 9 quando terminar o 2
  end;

  divisor := soma mod 11;

  if divisor < 2 then
    digito := 0
  else
    digito := 11 - divisor;

  if (digito <> StrToInt(ACNPJ[13])) then
  begin
    Application.MessageBox('CNPJ Inválido, confira os números informados',
      'Validador CNPJ', MB_ICONWARNING);
    exit;
  end;

  // Verificando o digito 14
  soma := 0;
  peso := 6;

  for i := 1 to 13 do
  begin
    soma := soma + (StrToInt(ACNPJ[i]) * peso);
    dec(peso); // peso := peso - 1;
    if (peso = 1) then peso := 9; //Altera o peso para 9 quando terminar o 2
  end;

  divisor := soma mod 11;

  if divisor < 2 then
    digito := 0
  else
    digito := 11 - divisor;

  if (digito <> StrToInt(ACNPJ[14])) then
  begin
    Application.MessageBox('CNPJ Inválido, confira os números informados',
      'Validador CNPJ', MB_ICONWARNING);
    exit;
  end;

  result := true;
end;

class function TUtilsRotinas.ValidaCPF(const ACPF: string): Boolean;
  var i, soma, peso, divisor, digito : Integer;
begin
  result := false; //Deixa o retorno já marcado como falso

  if (Length(ACPF) <> 11) then //Verifica se o ACPF contem os 11 digitos
  begin
    Application.MessageBox('CPF Inválido, informe todos os números',
      'Validador CPF', MB_ICONWARNING);
    exit;
    //O exit encerra a função e o result devolve o valor falso
  end;

  //Verificando o digito 10
  soma := 0;
  peso := 10;

  for i := 1 to 9 do
  begin
    soma := soma + (StrToInt(ACPF[i]) * peso);
    dec(peso); //ou peso := peso - 1;
  end;
  divisor := soma mod 11;

  if divisor < 2 then
    digito := 0
  else
    digito := 11 - divisor;

  if (digito <> StrToInt(ACPF[10])) then
  begin
    Application.MessageBox('CPF Inválido, confira os números informados',
      'Validador CPF', MB_ICONWARNING);
      exit;
  end;

  // Verificando o digito 11
  soma := 0;
  peso := 11;

  for i := 1 to 10 do
  begin
    soma := soma + (StrToInt(ACPF[i]) * peso);
    dec(peso); // peso := peso - 1;
  end;

  divisor := soma mod 11;

  if divisor < 2 then
    divisor := 0
  else
    digito := 11 - divisor;

  if (digito <> StrToInt(ACPF[11])) then
  begin
    Application.MessageBox('CPF Inválido, confira os números informados',
      'Validador CPF', MB_ICONWARNING);
    exit;
  end;
  //Chegou aqui, então o ACPF é válido

  result := true; // Chegando até o final o retorno é verdadeiro
end;

end.
