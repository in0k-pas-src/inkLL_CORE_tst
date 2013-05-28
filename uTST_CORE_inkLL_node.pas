unit uTST_CORE_inkLL_node;
(*$define testCase -- пометка для gitExtensions-Statickics что это файл ТЕСТ
  [Test
*)
{$mode objfpc}{$H+}
interface

uses fpcunit;

type

  {[Type TeST Core Test Case] узел списка над которым издеваемся}
 pTST_inkLL_Node=^rTST_inkLL_Node;
 rTST_inkLL_Node=record{rInkNodeLL}
    next:pTST_inkLL_Node;   //< ссылка-указатель на следующий элемент очереди
    nmbr:NativeInt;         //< просто число (индекс)
  end;

  {[Type TeST Core Test Case] САМ РОДОначальник тестов}
 tTSTCTC_CORE_inkLL=class(TTestCase)
  protected
    procedure _node_DST(Node:pTST_inkLL_Node);
    function  _node_CRT(Nmbr:NativeInt; Next:pTST_inkLL_Node):pTST_inkLL_Node;
  protected
    LIST:pointer; //< испытуемое
  protected
    procedure _list_DESTOY  (var   lst:pTST_inkLL_Node);
    function  _list_Create  (const Count:NativeInt;     out last:pTST_inkLL_Node):pTST_inkLL_Node;
    function  _list_clcCount(const lst:pTST_inkLL_Node; out last:pTST_inkLL_Node):NativeInt;
  protected
    procedure SetUp;    override;
    procedure TearDown; override;
  PUBLIC //< этим можно пользоваться при ТЕСТАХ
    procedure TST_node_DESTROY  (Node:pointer);
    function  TST_node_getNamber(Node:pointer):NativeInt;
    function  TST_node_getNext  (Node:pointer):pointer;
  end;

implementation

procedure tTSTCTC_CORE_inkLL.SetUp;
begin
    LIST:=NIL;
end;

procedure tTSTCTC_CORE_inkLL.TearDown;
begin
    if LIST<>nil then _list_DESTOY(LIST);
end;

//------------------------------------------------------------------------------

procedure tTSTCTC_CORE_inkLL._node_DST(Node:pTST_inkLL_Node);
begin
    dispose(Node)
end;

function tTSTCTC_CORE_inkLL._node_CRT(Nmbr:NativeInt; Next:pTST_inkLL_Node):pTST_inkLL_Node;
begin
    new(result);
    result^.next:=Next;
    result^.nmbr:=Nmbr;
end;

//------------------------------------------------------------------------------

procedure tTSTCTC_CORE_inkLL._list_DESTOY(var lst:pTST_inkLL_Node);
var tmp:pTST_inkLL_Node;
begin
    if lst<>nil then begin
        tmp:=lst;
        while tmp<>nil do begin
          lst:=tmp^.next;
         _node_DST(tmp);
          //--
          tmp:=lst;
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tTSTCTC_CORE_inkLL._list_Create(const Count:NativeInt; out last:pTST_inkLL_Node):pTST_inkLL_Node;
var i:NativeInt;
begin
    result:=NIL;
    last  :=NIL;
    if Count>0 then begin;
        last  :=_node_CRT(Count-1,NIL);
        result:=last;
        if Count>1 then begin
            for i:= (Count-2) downto (0) do begin
               result:=_node_CRT(i,result);
            end;
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tTSTCTC_CORE_inkLL._list_clcCount(const lst:pTST_inkLL_Node; out last:pTST_inkLL_Node):NativeInt;
begin
    result:=0;
    last  :=nil;
    if lst<>nil then begin
        result:=1;
        last  :=lst;
        while pTST_inkLL_Node(last)^.next<>nil do begin
            inc (result);
            last:=pTST_inkLL_Node(last)^.next;
        end;
    end;
end;

//------------------------------------------------------------------------------

function tTSTCTC_CORE_inkLL.TST_node_getNamber(Node:pointer):NativeInt;
begin
    result:=pTST_inkLL_Node(node)^.nmbr;
end;

function tTSTCTC_CORE_inkLL.TST_node_getNext(Node:pointer):pointer;
begin
    result:=pTST_inkLL_Node(node)^.next;
end;

//------------------------------------------------------------------------------

procedure tTSTCTC_CORE_inkLL.TST_node_DESTROY(Node:pointer);
begin
    _node_DST(Node);
end;

end.
