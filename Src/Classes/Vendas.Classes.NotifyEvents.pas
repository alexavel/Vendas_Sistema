unit Vendas.Classes.NotifyEvents;

interface

uses
  System.Classes, System.SysUtils;
type
  TNotifyEventosDispatcher = class(TComponent)
  protected
    FProcedureEmbeded: TProc<TObject>;
    procedure OnNotifyEvent(Sender: TObject);
  public
    class function Create(Owner: TComponent; const Closure: TProc<TObject>): TNotifyEvent; overload;

    function Attach(const Closure: TProc<TObject>): TNotifyEvent;
  end;

implementation

class function TNotifyEventosDispatcher.Create(Owner: TComponent; const Closure: TProc<TObject>): TNotifyEvent;
begin
  Result := TNotifyEventosDispatcher.Create(Owner).Attach(Closure)
end;

function TNotifyEventosDispatcher.Attach(const Closure: TProc<TObject>): TNotifyEvent;
begin
  FProcedureEmbeded := Closure;
  Result := Self.OnNotifyEvent
end;

procedure TNotifyEventosDispatcher.OnNotifyEvent(Sender: TObject);
begin
  if Assigned(FProcedureEmbeded) then
    FProcedureEmbeded(Sender)
end;

end.
