program pr63;
uses MSeznam;





procedure zdvoj(var A: ukSeznam);
	var Pom, Pom2: ukSeznam;

	begin
		Pom:=A;
		if not jePrazdny(A) then
			while Pom <> nil do begin
				if Pom^.data > 0 then begin
					new(Pom2);
					Pom2^.data:=Pom^.data;
					Pom2^.dalsi:=Pom^.dalsi;
					Pom^.dalsi:=Pom2;
				end;
				Pom:=Pom^.dalsi^.dalsi
			end;
	end;


var S: ukSeznam;


begin
	init(S);
	pridej(S,2);
	pridej(S,3);
	pridej(S,-5);
	pridej(S,-7);
	pridej(S,8);

	vypis(S);

	zdvoj(S);

	vypis(S)
end.

