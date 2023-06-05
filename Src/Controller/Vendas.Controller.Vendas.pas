unit Vendas.Controller.Vendas;

interface

uses
  System.Classes, Vendas.Classes.Utils, System.SysUtils ;

Type
  TVendaController = class
    FComponentEmbeded: TObject;
  private
    constructor Create(AEmbeded: TObject);
  public
    class function New(AEmbeded: TObject): TVendaController;
  end;

implementation

uses
  Vcl.DBCtrls, Vcl.Forms, Winapi.Windows, Vendas.Dao;

{ TVendaController }

constructor TVendaController.Create(AEmbeded: TObject);
begin
  FComponentEmbeded := AEmbeded;
end;

class function TVendaController.New(AEmbeded: TObject): TVendaController;
begin
  Result := Self.Create(AEmbeded)
end;

end.
