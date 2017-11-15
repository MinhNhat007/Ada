with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure lab4_BST is

type Node is
	record
		Data : Integer;
		Left, Right: access Node := Null;
	end record;
type TypeNode is access all Node;

procedure showTree(Tree : in TypeNode) is
	T : TypeNode := Tree;
begin
	if (T /= Null) then
		Put(T.Data'Img);
		Put("->(");
		showTree(Tree.Left);
		Put(",");
		showTree(Tree.Right);
		Put(")");
	end if;
end showTree;

procedure insertNull(Tree: in out TypeNode; D: in Integer) is
begin
	Tree := new Node;
	Tree.Data := D;
end insertNull;

procedure insertTree(Tree: in out TypeNode; D: in Integer) is
	T : TypeNode := Tree;
begin
	if (T = Null) then
		insertNull(T, D);
	else 
		if (D >= T.Data) then
			insertTree(T.Right, D);
		else insertTree(T.Left, D);
		end if;
	end if;
	Tree := T;
end insertTree;

function searchTree(Tree: in TypeNode; D: in Integer) return TypeNode is
	T: TypeNode := Tree;
begin
	if (T = Null) then
		return Null;
	else
		if (D > T.Data) then
			return searchTree(T.Right, D);
		else 
			if (D < T.Data) then
				return searchTree(T.Left, D);
			else 
				return T;
			end if;
		end if;	
	end if;
end searchTree;
 
Tree : TypeNode := Null;
N : TypeNode := Null;
begin
	Put_Line("Processing");
	showTree(Tree);
	New_Line;
	insertTree(Tree, 1);
	insertTree(Tree, 3);
	insertTree(Tree, 2);
	insertTree(Tree, 5);
	insertTree(Tree, 4);
	showTree(Tree);	
	New_Line;
	N := searchTree(Tree, 6);
	if (N = Null) then
		Put_Line("Can not find one");
	else
		Put("Found in tree value = ");
		Put_Line(N.Data'Img);
	end if;

end lab4_BST;
