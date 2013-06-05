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
    procedure _list_DESTOY  (var   lst:pTST_inkLL_Node);                                           virtual; abstract;
    function  _list_Create  (const Count:NativeInt;     out last:pTST_inkLL_Node):pTST_inkLL_Node; virtual; abstract;
    function  _list_clcCount(const lst:pTST_inkLL_Node; out last:pTST_inkLL_Node):NativeInt;       virtual; abstract;
  protected
    procedure SetUp;    override;
    procedure TearDown; override;
  PUBLIC //< этим можно пользоваться при ТЕСТАХ
    procedure TST_node_DESTROY(      Node:pointer);
    function  TST_node_Create (Nmbr:NativeInt):pointer;
    function  TST_node_Namber (const Node:pointer):NativeInt;
    function  TST_node_Next   (const Node:pointer):pointer;
  end;


procedure TST_inkLL_Node_DESTRoY(const Node:pointer);

implementation

procedure TST_inkLL_Node_DESTRoY(const Node:pointer);
begin
    dispose(pTST_inkLL_Node(Node))
end;

//==============================================================================

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
    TST_inkLL_Node_DESTRoY(Node);
end;

function tTSTCTC_CORE_inkLL._node_CRT(Nmbr:NativeInt; Next:pTST_inkLL_Node):pTST_inkLL_Node;
begin
    new(result);
    result^.next:=Next;
    result^.nmbr:=Nmbr;
end;

//------------------------------------------------------------------------------

function tTSTCTC_CORE_inkLL.TST_node_Namber(const Node:pointer):NativeInt;
begin
    result:=pTST_inkLL_Node(node)^.nmbr;
end;

function tTSTCTC_CORE_inkLL.TST_node_Next(const Node:pointer):pointer;
begin
    result:=pTST_inkLL_Node(node)^.next;
end;

//------------------------------------------------------------------------------

procedure tTSTCTC_CORE_inkLL.TST_node_DESTROY(Node:pointer);
begin
    _node_DST(Node);
end;

function tTSTCTC_CORE_inkLL.TST_node_Create(Nmbr:NativeInt):pointer;
begin
    result:=_node_CRT(Nmbr,NIL);
end;

end.
