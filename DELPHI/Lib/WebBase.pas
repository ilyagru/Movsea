unit WebBase;

interface
uses BaseTypes;

type

  TTaskNode = record
      Adr:string;
      Port:integer;
      ID:Integer;
  end;

  TTask = class            //mb part of task com
      TaskID:Integer;
      //Servers:array of TTaskNode;
      State:Integer;                //0 - cleared 1 (start) 2 (Get 1 rez) 3 get ful rez 4 ready 5 nedd destroy .. 20-40..errors
      Lframes: TFrames;
      ServerStates:array of Integer;
      TbestFr:array of array[0..3] of Real;
  end;

  TServerManager = class
       Tasks : array of TTask;
       TaskLen : integer;
       Servers : array of TTaskNode;
       function GetTask(TaskId:Integer):Integer; //create task from getfile
       function InitTask(Task:TTask):Integer; //send task to nodes
       function Update():Integer;
       //protocols
       function HowAU(Node:TTaskNode):string;
       //function HowAUSpec(Node:TTaskNode; Par:Integer=1):string;   //1 ~ HowAU, 0 - ping, 2 - tasks, 3 - Machine stat ...
       //function Ping(Node:TTaskNode):string;
       function HowAYrTsk(Node:TTaskNode; TaskID:integer):string;
       //function StopAllPls(Node:TTaskNode):string;
       //function StopItPls(Node:TTaskNode; TaskId:Integer):string;
       function StartDoItPls(Node:TTaskNode; Frames:TFrames; TaskId:Integer):string;
       //function RestartPls(Node:TTaskNode):string;
       //function DoCustomCodePls(Node:TTaskNode; Code:string):string;


  end;

  TnodeTask = record
      TaskID:Integer;
      State:Integer;                //0 - cleared 1 (start) 2 (Get 1 rez) 3 get ful rez 4 ready 5 nedd destroy .. 20-40..errors
      Lframes: TFrames;
      TbestFr:array of array[0..3] of Real;
  end;

  TNodeManager = class
      Tasks: array of TnodeTask;
      MainServerIP:string;
      MainServerPo:integer;
      //protocols
      function IDoneTask(TaskId:Integer; BestFr:array of Real):string;
      //Answer protocols //generete string answer that sends back, all of them get the cut string(without protocod)
      function OnHowAU(Params:string):string;
      function OnHowAUSpec(Params:string):string;
  end;


implementation

{ TServerManager }

function TServerManager.GetTask(TaskId: Integer): Integer;
var
  I:integer;
begin
    //Uncode
    //GetFrames
    for I:=0 to TaskLen do
    if Tasks[I].State = 5 then
    begin
       Tasks[I].State := 0;
       Tasks[I].TaskID:=TaskId;
       //Tasks[I].Lframes:=Frames;
       SetLength(Tasks[I].ServerStates, Length(Servers));
       Break;
    end;
    Result:=1;
end;

function TServerManager.HowAU(Node: TTaskNode): string;
begin

end;

function TServerManager.HowAYrTsk(Node: TTaskNode;
  TaskID: integer): string;
begin

end;

function TServerManager.InitTask(Task: TTask): Integer;
var
  I:integer;
 // FullState:integer;
begin
  // FullState:=-1;
   for I:=0 to Length(Task.ServerStates)-1 do
     Task.ServerStates[I]:=0;    //all ok but all stop

   for I:=0 to Length(Task.ServerStates)-1 do
   begin
      if StartDoItPls(Servers[I],Task.Lframes,Task.TaskID)<>'ist' then
        begin
         //FullState:=I;
         break;
        end else Task.ServerStates[I]:=1; //task started
   end;

   Result:=1;
end;

function TServerManager.StartDoItPls(Node: TTaskNode; Frames: TFrames;
  TaskId: Integer): string;
begin

end;

function TServerManager.Update: Integer;
var I,J:integer;
begin
    for I:=0 to TaskLen do
    begin
      if Tasks[I].State = 1 then
      begin
          for J:=0 to Length(Servers)-1 do
            if HowAYrTsk(Servers[I],Tasks[I].TaskID) <> 'imok' then
            begin

            end;
      end;
    end;
    Result:=1;
end;

{ TNodeManager }

function TNodeManager.IDoneTask(TaskId: Integer;
  BestFr: array of Real): string;
begin

end;

function TNodeManager.OnHowAU(Params: string): string;
begin

end;

function TNodeManager.OnHowAUSpec(Params: string): string;
begin

end;


end.
