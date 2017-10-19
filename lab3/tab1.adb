with Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Float_Random;
use Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Float_Random;

--main function, run from this function
procedure Tab1 is
	type Vector is array(Integer range <>) of Float;
	VectorTest: Vector(1..10) := (1|3|5|7 => 1.2, 8..10 => 2.4, others => 7.6);
	
	--show vector on terminal
	procedure Show_Vector(Data: Vector) is
	begin
		for I in Data'First..Data'Last loop
			Put("Vector(" &I'Img&") =");
			Put(Data(I), 3, 4, 0);
			New_Line;
		end loop;
	end Show_vector;
	
	--randomize values for vector
	procedure Init_Vector(Data: out Vector) is
		Gen: Generator;
	begin
		Reset(Gen);
		for I in Data'First..Data'Last loop
			Data(I) := Random(Gen);
		end loop;
	end Init_Vector;
	
	--check increasing vector
	function Check_Rising_Vector(Data: Vector) return Boolean is
		(for all I in Data'First..(Data'Last - 1) => Data(I) <= Data(I+1) );
	
begin
	Show_Vector(VectorTest);
	Init_Vector(VectorTest);
	Put_Line("After random");
	Show_Vector(VectorTest);
	Put("Is the vector rising: "&Check_Rising_Vector(VectorTest)'Img&"");
end Tab1;