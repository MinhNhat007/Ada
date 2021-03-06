with Ada.Text_IO,Ada.Numerics.Float_Random,Ada.Numerics.Discrete_Random;
use Ada.Text_IO,Ada.Numerics.Float_Random;

procedure lab6 is
	type Kolory is (Czerwony, Zielony, Niebieski);
	package Los_Kolor is new Ada.Numerics.Discrete_Random(Kolory);
	use Los_Kolor;
	type Dzien is (Poniedzialek, Wtorek, Sroda, Czwartek, Piatek, Sobota, Niedziela);
	package Los_Dzien is new Ada.Numerics.Discrete_Random(Dzien);
	use Los_Dzien;
	--G_kolor : Generator;

	task Server is
    	entry Start;
    	entry Finish;
    	entry MakeRandom;
	end Server;

	task Client is
    	entry StartConnect;
		entry DisConnect;
  	end Client;

  	task body Server is
		GKolor: Los_Kolor.Generator;
    	GNumber : Ada.Numerics.Float_Random.Generator;
		GDzien: Los_Dzien.Generator;
    	RandomNumber: Float;
		RandomKolor: Kolory;
		RandomDzien: Dzien;
  	begin
	  	accept Start;
      		Put_Line("Server just accepted klient");
		loop
			select
    			accept MakeRandom;
					Reset(GNumber);
      				RandomNumber := Random(GNumber);
					RandomNumber := RandomNumber * 5.0;

					Reset(GKolor);
					RandomKolor := Los_Kolor.Random(GKolor);

					Reset(GDzien);
					RandomDzien := Los_Dzien.Random(GDzien);

      				Put_Line("Number generated by random is " & RandomNumber'Img);
   					Put_Line("Kolor generated by random is " &RandomKolor'Img);
					Put_Line("Dzien generated by random is " &RandomDzien'Img);
				else
					delay 0.01;
			end select;
			select
    			accept Finish;
      				Put_Line("Disconnecting to server");
					exit;
				else
					delay 0.01;
			end select;
		end loop;
  	end Server;

  	task body Client is
  	begin
    	accept StartConnect;
    		Server.Start;
    		Server.MakeRandom;
			Server.MakeRandom;
			Server.MakeRandom;
		accept DisConnect;
			Server.Finish;
  	end Client;

begin
		Client.StartConnect;
		Client.DisConnect;
end lab6;
