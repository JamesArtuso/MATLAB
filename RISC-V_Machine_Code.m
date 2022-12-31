% This script is meant to convert machine code to RISC-V
% commands.


%input = '00000000110100111000011110110011'; %add
%input = '00010001101011100101000001100011';
input = '00000000011000010011001010000011'; %ld
input = appendZero(input)

storage = [
    "lui"  ,"0110111", "NaN" , "u" , "NaN";
    "jal"  ,"1101111", "Nan" , "j" , "NaN";
    "beq"  ,"1100011", "000" , "b" , "NaN";
    "bne"  ,"1100011", "001" , "b" , "NaN";
    "blt"  ,"1100011", "100" , "b" , "NaN";
    "bge"  ,"1100011", "101" , "b" , "NaN";
    "lb"   ,"0000011", "000" , "il", "NaN";
    "lh"   ,"0000011", "001" , "il", "NaN"; 
    "lw"   ,"0000011", "010" , "il", "NaN";
    "ld"   ,"0000011", "011" , "il", "NaN";
    "sb"   ,"0100011", "000" , "s" , "NaN";
    "sh"   ,"0100011", "001" , "s" , "NaN";
    "sw"   ,"0100011", "010" , "s" , "NaN";
    "sd"   ,"0100011", "011" , "s" , "NaN";
    "addi" ,"0010011", "000" , "i" , "NaN";
    "xori" ,"0010011", "100" , "i" , "NaN";
    "ori"  ,"0010011", "110" , "i" , "NaN";
    "andi" ,"0010011", "111" , "i" , "NaN";
    "slli" ,"0010011", "001" , "i" , "NaN";
    "srli" ,"0010011", "101" , "i" , "NaN";
    "add"  ,"0110011", "000" , "r" , "0000000";
    "sub"  ,"0110011", "000" , "r" , "0100000";
    "xor"  ,"0110011", "100" , "r" , "0000000";
    "or"   ,"0110011", "110" , "r" , "0000000";
    "and"  ,"0110011", "111" , "r" , "0000000";
    "sra"  ,"0110011", "101" , "r" , "0100000";
    "srl"  ,"0110011", "101" , "r" , "0000000"
    ];


opcode = extractBetween(input, 26, 32);
func3 = extractBetween(input , 18, 20);
func7 = extractBetween(input, 1, 7);
rd = d2a(toMat(extractBetween(input, 21, 25)));
type = storage(rowLookup(opcode, func3, storage, func7), 4);
switch type
    case "r"
        rType(input, storage(rowLookup(opcode, func3, storage, func7),1))
    case "i"
        iType(input, storage(rowLookup(opcode, func3, storage, func7),1))
    case "s"
        sType(input, storage(rowLookup(opcode, func3, storage, func7),1))
    case "b"
        bType(input, storage(rowLookup(opcode, func3, storage, func7),1))
    case "il"
        ilType(input, storage(rowLookup(opcode, func3, storage, func7),1))
    case "u"
        uType(input, storage(rowLookup(opcode, func3, storage, func7),1))     
end


%Testing of methods
%bType(input, storage(rowLookup(opcode, func3, storage, func7), 1))
%rType(input, storage(rowLookup(opcode, func3, storage),1))
%ilType(input, storage(rowLookup(opcode, func3, storage), 1))
%sType(input, storage(rowLookup(opcode, func3, storage), 1))

function rowNum = rowLookup(opcode, func3, mat, func7)
    rowNum = -1;
    for i = (1:size(mat,1))
       if(strcmp(opcode, mat(i, 2)) & strcmp(func3,mat(i,3)))
           rowNum = i;
           i = size(mat, 1)+1;
       end
    end
    
    
    if(rowNum == -1)
        for i = (1:2)
            if(strcmp(opcode, mat(i, 2)))
                rowNum = i;
                i = size(mat, 1)+1;
            end
        end
    end
    
    if(rowNum == -1)
        error("OPCODE NOT FOUND!    TRY SRIKI OPCODE OR INSTRUCTION SET OPCODE!!");
    end
    
    if(strcmp(mat(rowNum,4), "r"))
       for i = (21:size(mat,1))
            if(strcmp(opcode, mat(i, 2)) & strcmp(func3,mat(i,3)) & strcmp(func7, mat(i,5)))
                rowNum = i;
                i = size(mat, 1)+1;
            end
       end
    end
end

function returnString = rType(i, command)
    rd = string(d2a(toMat(extractBetween(i, 21, 25)),1));
    rs1 = string(d2a(toMat(extractBetween(i, 13, 17)),1));
    rs2 = string(d2a(toMat(extractBetween(i, 8, 12)),1));
    returnString = strcat(command, " x", rd, ", x", rs1, ", x", rs2);
end

function returnString = iType(i, command)
    rd = string(d2a(toMat(extractBetween(i, 21, 25)),1));
    rs1 = string(d2a(toMat(extractBetween(i, 13, 17)),1));
    imm = string(d2a(toMat(extractBetween(i, 1, 12))));
    returnString = strcat(command, " x", rd, ", x", rs1, ", ",imm);
end

function returnString = ilType(i, command)
    rd = string(d2a(toMat(extractBetween(i, 21, 25)),1));
    rs1 = string(d2a(toMat(extractBetween(i, 13, 17)),1));
    imm = string(d2a(toMat(extractBetween(i, 1, 12))));
    returnString = strcat(command, " x", rd, ", ",imm, "(x" , rs1,")");
end

function returnString = sType(i, command)
    imm40 = toMat(extractBetween(i, 21, 25));
    rs1 = string(d2a(toMat(extractBetween(i, 13, 17)),1));
    rs2 = string(d2a(toMat(extractBetween(i, 8, 12)),1));
    imm115= toMat(extractBetween(i, 1, 7));
    imm = string(d2a([imm115 imm40]));
    returnString = strcat(command, " x", rs2, ", ", imm, "(x", rs1, ")");
end

%NEED TO IMPLEMENT BTYPE
function returnString = bType(i, command)
    imm41 = toMat(extractBetween(i, 21, 24));
    imm11 = toMat(extractBetween(i, 25, 25));
    imm12 = toMat(extractBetween(i, 1, 1));
    imm105= toMat(extractBetween(i, 2, 7));
    rs1 = string(d2a(toMat(extractBetween(i, 13, 17)),1));
    rs2 = string(d2a(toMat(extractBetween(i, 8, 12)),1));
    imm = string(d2a([imm12 imm11 imm105 imm41 0]));
    
    returnString = strcat(command, " x", rs1, ", x", rs2,", ", imm);
end

function returnString = uType(i, command)
    imm = string(d2a(toMat(extractBetween(i, 1, 20))));
    rd = string(d2a(toMat(extractBetween(i, 21, 25)),1));
    returnString = strcat(command, ", x", rd, ", ", imm);
end

function mat = toMat(x)
    mat = zeros(strlength(x),1);
    i = 0;
    while( i < strlength(x))
       mat(strlength(x)-i) = str2double(extractBetween(x,strlength(x)-i, strlength(x)-i));
       i= i+1;
    end
    mat = mat';
end

function newStr = appendZero(i)
    while(strlength(i) < 32)
        i = strcat("0", i);
    end
    newStr = i;
end

function x = d2a(b,type)

    if nargin==0, help d2a; return; end
    if nargin==1, type=-1; end

    B = size(b,2);             % number of bits

    b(:,1) = type*b(:,1);      %  negative sign for 2's complement representation

    x = b * 2.^(B-1:-1:0)';
end