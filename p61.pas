program p61;

type TData = string; 
	 ukPrvek = ^Prvek;
	 Prvek = record 
	 	Data: TData;
	 	Dalsi: ukPrvek
	 end;

function rozdel(R: string; Z: char; var G: file): ukPrvek;
var Pom, Usek: string;
	Pozice: byte;
	S, Pom2: ukPrvek;
	

begin
	assign(G,'p61_vystup.bin');
	S:=nil;
	Pom:=R;
	if (Pom <> '') then begin
		Pozice:=pos(Z,Pom);
		rewrite(G,1);

		//writeln('pozice prvni mezery je ', Pozice);
		if (Pozice <> 0) then begin
			Usek:=copy(Pom, 1, Pozice-1);
			writeln('nove slovo: ',usek);
			delete(Pom, 1, Pozice);
			new(S);
			S^.Data:=Usek;
			S^.Dalsi:=nil;

			blockwrite(G,S^.Data, length(S^.Data)+1);
			writeln('bylo zapsano do souboru: ', length(S^.Data)+1);

			while (Pom <> '') do begin
				Pozice:=pos(Z,Pom);
				if (Pozice = 0) then begin
					 Usek:=Pom;
					 delete(Pom, 1, length(Pom));

				end else begin
				 	Usek:=copy(Pom, 1, Pozice-1);
				 	delete(Pom, 1, Pozice);
				end;
				
				writeln('nove slovo: ',usek);
				
				{ Zasobnik }
				new(Pom2);
				Pom2^.Data:=Usek;
				Pom2^.Dalsi:=S;
				S:=Pom2;
				

				blockwrite(G,S^.Data, length(S^.Data)+1);
				writeln('bylo zapsano do souboru: ', length(S^.Data)+1);

			

				
				
			end;
		end else begin
			new(S);
			S^.Data:=Pom;
			S^.Dalsi:=nil
		end;
		close(G);
	end;
	rozdel:=S;
end;




var Seznam: ukPrvek;
	F: file;
	S: string;
	skutecne: word;
	Pocet, I,adresa: word;
	
	
begin
	Seznam:=rozdel('Ahoj jak se mas', ' ',F);

	assign(F,'p61_vystup.bin');
	reset(F,1);
	blockread(F,S, length(S)+1, skutecne);
	writeln(S);
	pocet:=fileSize(F);
	adresa:=1;
	for I:=1 to pocet do begin
		blockread(F,S, 1, skutecne);
		if (skutecne=1) then begin
			blockread(F,S[1],length(S),skutecne);
			writeln(S[1])
		end;
	end;

	close(F);
	

end.