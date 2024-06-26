#help_index "Graphics/Misc"
asm
{//************************************
  _GR_UPDATE_LINE64::
  PUSH	RBP
  MOV	RBP,RSP
  PUSH	RSI
  PUSH	RDI

  MOV	RAX,U64 SF_ARG2[RBP]
  MOV	RSI,U64 [RAX]		//rsi=src
  MOV	RBX,U64 [&rev_bits_table]
  MOV	RCX,U64 SF_ARG3[RBP]	//rcx=d
  MOV	RAX,U64 SF_ARG4[RBP]
  MOV	RDI,U64 [RAX]		//rdi=image

  MOV	RAX,U64 SF_ARG1[RBP]
  MOV	R8,U64 [RAX]		//rbp=vga dst

@@05:	LODSQ
  CMP	U64 [RDI],RAX
  JE	@@10
  MOV	U64 [RDI],RAX
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  MOV	U64 [R8],RAX
@@10:	ADD	RDI,8
  ADD	R8,8
  DEC	RCX
  JNZ	@@05

  MOV	RAX,U64 SF_ARG1[RBP]
  MOV	U64 [RAX],R8
  MOV	RAX,U64 SF_ARG4[RBP]
  MOV	U64 [RAX],RDI
  MOV	RAX,U64 SF_ARG2[RBP]
  MOV	U64 [RAX],RSI
  POP	RDI
  POP	RSI
  POP	RBP
  RET1	32
//************************************
  _GR_UPDATE_LINE64_FLUSH_CACHE::
  PUSH	RBP
  MOV	RBP,RSP
  PUSH	RSI
  PUSH	RDI

  MOV	RAX,U64 SF_ARG2[RBP]
  MOV	RSI,U64 [RAX]		//rsi=src
  MOV	RBX,U64 [&rev_bits_table]
  MOV	RCX,U64 SF_ARG3[RBP]	//rcx=d
  MOV	RAX,U64 SF_ARG4[RBP]
  MOV	RDI,U64 [RAX]		//rdi=image

  MOV	RAX,U64 SF_ARG1[RBP]
  MOV	R8,U64 [RAX]		//rbp=vga dst

@@05:	LODSQ
  MOV	U64 [RDI],RAX
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  XLATB
  ROR	RAX,8
  MOV	U64 [R8],RAX
  ADD	RDI,8
  ADD	R8,8
  DEC	RCX
  JNZ	@@05

  MOV	RAX,U64 SF_ARG1[RBP]
  MOV	U64 [RAX],R8
  MOV	RAX,U64 SF_ARG4[RBP]
  MOV	U64 [RAX],RDI
  MOV	RAX,U64 SF_ARG2[RBP]
  MOV	U64 [RAX],RSI
  POP	RDI
  POP	RSI
  POP	RBP
  RET1	32
//************************************
  _DC_BLOT_COLOR4::
  PUSH	RBP
  MOV	RBP,RSP
  PUSH	RSI
  PUSH	RDI
  PUSH	R10

  MOV	RDI,U64 SF_ARG1[RBP]
  MOV	RSI,U64 SF_ARG2[RBP]
  MOV	RBX,U64 SF_ARG3[RBP]
  MOV	RCX,U64 SF_ARG4[RBP]

  MOV	R8,RDI
  ADD	R8,RCX
  MOV	R9,R8
  ADD	R9,RCX
  MOV	R10,R9
  ADD	R10,RCX

@@5:	LODSQ
  MOV	RDX,U64 [RBX]
  CMP	RAX,RDX
  JE	I32 @@10
  MOV	U64 [RBX],RAX

  XOR	RDX,RDX
  BT	RAX,7*8+0
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,6*8+0
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,5*8+0
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,4*8+0
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,3*8+0
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,2*8+0
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,1*8+0
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,0*8+0
  ADC	RDX,0
  MOV	U8 [RDI],DL

  XOR	RDX,RDX
  BT	RAX,7*8+1
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,6*8+1
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,5*8+1
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,4*8+1
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,3*8+1
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,2*8+1
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,1*8+1
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,0*8+1
  ADC	RDX,0
  MOV	U8 [R8],DL

  XOR	RDX,RDX
  BT	RAX,7*8+2
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,6*8+2
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,5*8+2
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,4*8+2
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,3*8+2
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,2*8+2
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,1*8+2
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,0*8+2
  ADC	RDX,0
  MOV	U8 [R9],DL

  XOR	RDX,RDX
  BT	RAX,7*8+3
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,6*8+3
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,5*8+3
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,4*8+3
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,3*8+3
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,2*8+3
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,1*8+3
  ADC	RDX,0
  SHL1	RDX
  BT	RAX,0*8+3
  ADC	RDX,0
  MOV	U8 [R10],DL

@@10:	ADD	RBX,8

  INC	RDI
  INC	R8
  INC	R9
  INC	R10

  DEC	RCX
  JNZ	I32 @@5

  POP	R10
  POP	RDI
  POP	RSI
  POP	RBP
  RET1	32
//************************************
  _IS_PIX_COVERED0::
  PUSH	RBP
  MOV	RBP,RSP
#assert FONT_WIDTH==FONT_HEIGHT==8
  MOV	RCX,U64 SF_ARG3[RBP]
  SAR	RCX,3
  MOV	RAX,U64 SF_ARG2[RBP]
  SAR	RAX,3
  MOV	RDX,U64 SF_ARG1[RBP]
  IMUL2	RCX,TEXT_COLS
  MOV	RBX,U64 [&gr.win_z_buf]
  MOV	DX,U16 CTask.win_z_num[RDX]
  ADD	RCX,RAX
  XOR	RAX,RAX
  CMP	DX,U16 [RBX+RCX*2]
  JAE	@@05	//Jump not covered
  INC	RAX
@@05:	POP	RBP
  RET1	24
//************************************
  _GR_ROP_EQU_U8_NO_CLIPPING::
//Puts foreground char shape onto gr.dc2.
//ch.u8[1] is color as a whole byte
//ch ATTRf_UNDERLINE attr flag is used.
  PUSH	RBP
  MOV	RBP,RSP
  MOVZX	RAX,U8 SF_ARG1[RBP]
  MOV	RDX,U64 [&text.font]
  MOV	RAX,U64 [RDX+RAX*8]	//RAX is 8x8 char font data, 64-bits
  BT	U64 SF_ARG1[RBP],ATTRf_UNDERLINE
  JNC	@@05
  MOV	RBX,0xFF00000000000000
  OR	RAX,RBX
@@05:	TEST	RAX,RAX
  JZ	I32 @@10

  PUSH	RSI
  PUSH	RDI
  MOVZX	RBX,U8 SF_ARG1+1[RBP]	//Warning color is 8-bit
  MOV	RDX,U64 [&gr.to_8_colors]
  MOV	R8,U64 [RDX+RBX*8]	//R8 is color repeated 8 times.
  MOV	R9,U64 SF_ARG3[RBP]	//R9 is width_internal
  MOV	RDI,U64 SF_ARG2[RBP]
  MOV	RSI,U64 [&gr.to_8_bits] //RSI is gr.to_8_bits

//	m=my_1_to_8_bits[ch&255];ch>>=8;
//	*dst=*dst&~m|c&m;
//	dst(U8 *)+=w1;

  MOVZX	RBX,AL
  MOV	RDX,U64 [RSI+RBX*8]
  SHR	RAX,8
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX
  ADD	RDI,R9

  MOVZX	RBX,AL
  MOV	RDX,U64 [RSI+RBX*8]
  SHR	RAX,8
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX
  ADD	RDI,R9

  MOVZX	RBX,AL
  MOV	RDX,U64 [RSI+RBX*8]
  SHR	RAX,8
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX
  ADD	RDI,R9

  MOVZX	RBX,AL
  MOV	RDX,U64 [RSI+RBX*8]
  SHR	RAX,8
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX
  ADD	RDI,R9

  MOVZX	RBX,AL
  MOV	RDX,U64 [RSI+RBX*8]
  SHR	RAX,8
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX
  ADD	RDI,R9

  MOVZX	RBX,AL
  MOV	RDX,U64 [RSI+RBX*8]
  SHR	RAX,8
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX
  ADD	RDI,R9

  MOVZX	RBX,AL
  MOV	RDX,U64 [RSI+RBX*8]
  SHR	RAX,8
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX
  ADD	RDI,R9

  MOV	RDX,U64 [RSI+RAX*8]
  MOV	RBX,U64 [RDI]
  MOV	RCX,RDX
  NOT	RCX
  AND	RDX,R8
  AND	RCX,RBX
  OR	RCX,RDX
  MOV	U64 [RDI],RCX

  POP	RDI
  POP	RSI
@@10:	POP	RBP
  RET1	24
}
_extern _GR_ROP_EQU_U8_NO_CLIPPING U0 GrRopEquU8NoClipping(I64 ch,
    U8 *dst,I64 width_internal);
public _extern _IS_PIX_COVERED0 Bool IsPixCovered0(
CTask *task,I64 x,I64 y);//No clipping

_extern _GR_UPDATE_LINE64 U0 GrUpdateLine64(
U64 **_vga,U64 **_src,I64 d,U8 **_dst);
_extern _GR_UPDATE_LINE64_FLUSH_CACHE U0 GrUpdateLine64FlushCache(
U64 **_vga,U64 **_src,I64 d,U8 **_dst);
_extern _DC_BLOT_COLOR4 U0 DCBlotColor4(
U8 *dst,I64 *img,I64 *img_cache,I64 cnt);
