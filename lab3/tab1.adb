with Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Float_Random,Ada.Calendar;
use Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Float_Random,Ada.Calendar;

--main function, run from this function
procedure Tab1 is
	type Vector is array(Integer range <>) of Float;
	VectorTest: Vector(1..10) := (1|3|5|7 => 1.2, 8..10 => 2.4, others => 7.6);
	T1,T2: Time;
	
	--show vector on terminal
	procedure Show_Vector(Data: in Vector) is
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
	function Check_Rising_Vector(Data: in Vector) return Boolean is
		(for all I in Data'First..(Data'Last - 1) => Data(I) <= Data(I+1) );

	--bubble sort
	procedure Sort_Vector(Data: out Vector) is
		T: Float;
	begin
		for I in Data'First..(Data'Last - 1) loop
			for J in I..Data'Last loop
			if (Data(I) > Data(j)) then
				T := Data(I);
				Data(I) := Data(J);
				Data(J) := T;
			end if;
			end loop;
		end loop;
	end Sort_Vector;
	
	--store data to file
	procedure Move_To_File(Data: Vector) is
		File_Handle: File_Type;
		package FTIO is new Ada.Text_IO.Float_IO (Float);
	begin
		Create(File_Handle, Out_File, "container.txt");
		for I in Data'First..Data'Last loop
			FTIO.Put(File_Handle, Data(I));
		end loop;
		Close(File_Handle);
	end Move_To_File;
begin
	T1 := Clock;
	Show_Vector(VectorTest);
	Init_Vector(VectorTest);
	Put_Line("After random");
	Show_Vector(VectorTest);
	Put_Line("Is the vector rising: "&Check_Rising_Vector(VectorTest)'Img&"");
	Sort_Vector(VectorTest);
	Put_Line("After sort");
	Show_Vector(VectorTest);
	T2 := Clock;
	Put_Line("Time implementation = "&Duration(T2 - T1)'Img&"");
	Move_To_File(VectorTest);
end Tab1;
