/*This highlights the 4th dimension
of the transformation matrix which
is used for storing translations (shifts)
in matricies so they can be combined
with a matrix multiplication.

Scroll bar works.

The multiplication takes place in the
$LK,"Sprite3ZB",A="MN:Sprite3ZB"$ routine.
*/

#define SLIDER_SPACING 20
#define SLIDER_RANGE   30
#define SLIDER_BORDER  2

class CSliderState
{
  I64 s1,s2,s3;
  F64 arg1,arg2,scale;
} s;

U0 DrawCtrlSlider(CDC *dc,CCtrl *c)
{
  CSliderState *s=c->state;

  dc->color=LTGREEN;
  GrRect(dc, c->left,c->top,SLIDER_SPACING*4+3,SLIDER_SPACING*2+SLIDER_RANGE);
  dc->color=BROWN;
  GrRect(dc, c->left+SLIDER_BORDER,c->top+SLIDER_BORDER,
        SLIDER_SPACING*4+3-2*SLIDER_BORDER,
        SLIDER_SPACING*2+SLIDER_RANGE-2*SLIDER_BORDER);
  dc->color=BLACK;
  GrLine(dc,c->left+SLIDER_SPACING,c->top+SLIDER_SPACING,
        c->left+SLIDER_SPACING,c->top+SLIDER_SPACING+SLIDER_RANGE-1);
  GrLine(dc,c->left+2*SLIDER_SPACING+1,c->top+SLIDER_SPACING,
        c->left+2*SLIDER_SPACING+1,c->top+SLIDER_SPACING+SLIDER_RANGE-1);
  GrLine(dc,c->left+3*SLIDER_SPACING+2,c->top+SLIDER_SPACING,
        c->left+3*SLIDER_SPACING+2,c->top+SLIDER_SPACING+SLIDER_RANGE-1);

  dc->color=LTGREEN;
  GrPrint(dc,c->left+SLIDER_SPACING-FONT_WIDTH/2,
        c->top+SLIDER_SPACING+SLIDER_RANGE+3,
        "%d",s->s1*10/SLIDER_RANGE);
  GrPrint(dc,c->left+2*SLIDER_SPACING+1-FONT_WIDTH/2,
        c->top+SLIDER_SPACING+SLIDER_RANGE+3,
        "%d",s->s2*10/SLIDER_RANGE);
  GrPrint(dc,c->left+3*SLIDER_SPACING+2-FONT_WIDTH/2,
        c->top+SLIDER_SPACING+SLIDER_RANGE+3,
        "%d",s->s3*10/SLIDER_RANGE);
  GrRect(dc,c->left+SLIDER_SPACING-3,
        c->top+SLIDER_SPACING+SLIDER_RANGE-1-s->s1-2 ,7,5);
  GrRect(dc,c->left+2*SLIDER_SPACING+1-3,
        c->top+SLIDER_SPACING+SLIDER_RANGE-1-s->s2-2,7,5);
  GrRect(dc,c->left+3*SLIDER_SPACING+2-3,
        c->top+SLIDER_SPACING+SLIDER_RANGE-1-s->s3-2,7,5);
  dc->color=GREEN;
  GrRect(dc,c->left+SLIDER_SPACING-2,
        c->top+SLIDER_SPACING+SLIDER_RANGE-1-s->s1-1 ,5,3);
  GrRect(dc,c->left+2*SLIDER_SPACING+1-2,
        c->top+SLIDER_SPACING+SLIDER_RANGE-1-s->s2-1,5,3);
  GrRect(dc,c->left+3*SLIDER_SPACING+2-2,
        c->top+SLIDER_SPACING+SLIDER_RANGE-1-s->s3-1,5,3);
}

U0 UpdateDerivedCtrlSlider(CCtrl *c)
{
  CSliderState *s=c->state;
  c->left=c->win_task->pix_width/2-(SLIDER_SPACING*4+3)/2;
  c->right=c->left+SLIDER_SPACING*4+3;
  c->top=c->win_task->pix_height/2-(SLIDER_SPACING*2+SLIDER_RANGE)/2;
  c->bottom=c->top+SLIDER_SPACING*2+SLIDER_RANGE;
  s->s1=ClampI64(s->s1,0,SLIDER_RANGE-1);
  s->s2=ClampI64(s->s2,0,SLIDER_RANGE-1);
  s->s3=ClampI64(s->s3,1,SLIDER_RANGE-1);
  s->arg1=�/2.0*s->s1/SLIDER_RANGE;
  s->arg2=1.0*(s->s2-SLIDER_RANGE/2)/SLIDER_RANGE;
  s->scale=2.0*s->s3/SLIDER_RANGE;
}

U0 LeftClickSlider(CCtrl *c,I64 x,I64 y,Bool)
{
  CSliderState *s=c->state;
  if (x<c->left+(c->right-c->left)/3)
    s->s1=SLIDER_RANGE-1-(y-(c->top+SLIDER_SPACING));
  else if (x<c->left+2*(c->right-c->left)/3)
    s->s2=SLIDER_RANGE-1-(y-(c->top+SLIDER_SPACING));
  else
    s->s3=SLIDER_RANGE-1-(y-(c->top+SLIDER_SPACING));
  if (c->update_derived_vals)
    (*c->update_derived_vals)(c);
}

CCtrl *SliderNew()
{
  CCtrl *c=CAlloc(sizeof(CCtrl));
  c->win_task=Fs;
  c->flags=CTRLF_SHOW|CTRLF_CAPTURE_LEFT_MS;
  c->type=CTRLT_GENERIC;
  c->state=&s;
  MemSet(&s,0,sizeof(s));
  c->draw_it=&DrawCtrlSlider;
  c->left_click=&LeftClickSlider;
  c->update_derived_vals=&UpdateDerivedCtrlSlider;
  QueIns(c,Fs->last_ctrl);
  TaskDerivedValsUpdate;
  return c;
}

U0 SliderDel(CCtrl *c)
{
  QueRem(c);
  Free(c);
}





$SP,"<1>",BI=1$

#define MAP_HEIGHT	2048
#define MAP_WIDTH	2048

#define TREES_NUM	256

I64 tree_x[TREES_NUM],tree_y[TREES_NUM];

class MPCtrl {
  I64 mp_cnt;
  I64 r[16];
  F64 a;
} mp;

I64 mp_not_done_flags;

U0 MPDrawIt(CTask *task)
{
  CDC *dc=DCAlias(gr.dc2,task);
  I64 i,lo=Gs->num*TREES_NUM/mp.mp_cnt,hi=(Gs->num+1)*TREES_NUM/mp.mp_cnt;
  MemCpy(dc->r,mp.r,sizeof(I64)*16);
  dc->flags|=DCF_TRANSFORMATION;
  for (i=lo;i<hi;i++)
    Sprite3ZB(dc,tree_x[i],
	  tree_y[i],0,$IB,"<tree>",BI=1$,mp.a);
  DCDel(dc);
  LBtr(&mp_not_done_flags,Gs->num);
}

U0 DrawIt(CTask *task,CDC *dc)
{
  I64 i,h,v;
  task->horz_scroll.min=-s.scale*MAP_HEIGHT*Sin(s.arg1);
  task->horz_scroll.max=s.scale*MAP_WIDTH*Cos(s.arg1)-task->pix_width;
  task->vert_scroll.min=0;
  task->vert_scroll.max=s.scale*(MAP_HEIGHT*Cos(s.arg1)+MAP_WIDTH*Sin(s.arg1))
  -task->pix_height;
  TaskDerivedValsUpdate(task);

  h=task->horz_scroll.pos;
  v=task->vert_scroll.pos;

  Mat4x4RotZ(dc->r,s.arg1);
  Mat4x4Scale(dc->r,s.scale);
  DCMat4x4Set(dc,dc->r);
  Mat4x4TranslationEqu(dc->r,-h,-v,0);
  MemCpy(mp.r,dc->r,sizeof(I64)*16);
  mp.a=s.arg2;

  mp_not_done_flags=1<<mp_cnt-1;
  for (i=0;i<mp.mp_cnt;i++)
    JobQue(&MPDrawIt,task,i);
  while (mp_not_done_flags)
    Yield;

  dc->flags|=DCF_TRANSFORMATION;
  dc->color=BROWN;
  dc->thick=4;
  GrLine3(dc,2,2,0,MAP_WIDTH-3,2,0);
  GrLine3(dc,2,MAP_HEIGHT-3,0,MAP_WIDTH-3,MAP_HEIGHT-3,0);
  GrLine3(dc,2,2,0,2,MAP_HEIGHT-3,0);
  GrLine3(dc,MAP_WIDTH-3,2,0,MAP_WIDTH-3,MAP_HEIGHT-3,0);
}

U0 Init()
{
  I64 i;
  for (i=0;i<TREES_NUM;i++) {
    tree_x[i]=RandU16%MAP_WIDTH;
    tree_y[i]=RandU16%MAP_HEIGHT;
  }
}

U0 TransformDemo(I64 _mp_cnt=mp_cnt)
{
  SettingsPush; //See $LK,"SettingsPush",A="MN:SettingsPush"$
  Init;
  Fs->win_inhibit=WIG_TASK_DFT-WIF_SELF_FOCUS-WIF_SELF_BORDER
        -WIF_SELF_GRAB_SCROLL-WIF_FOCUS_TASK_MENU-WIF_SELF_CTRLS;
  Fs->draw_it=&DrawIt;
  WinBorder(ON);
  DocCursor;
  DocClear;
  DocScroll;

  Fs->horz_scroll.pos=0;
  Fs->vert_scroll.pos=0;
  CCtrl *c=SliderNew;
  s.s1=0;
  s.s2=SLIDER_RANGE/2;
  s.s3=SLIDER_RANGE/2;

  MemSet(&mp,0,sizeof(MPCtrl));
  mp.mp_cnt=_mp_cnt;

  View;
  SliderDel(c);
  SettingsPop;
//You might want to save the original state of the scroll bars.
}

TransformDemo;
        j     ��������(   O   �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
�������������������������������������


������������������������������������


����������������������������������


��������������������������������




�������������������������������


������������������������������




�����������������������������



����������������������������


��������������������������



������������������������



����������������������



���������������������









������������������������












�������������������������


������������������������


���������������������






������������������






������������������



����������������������




�������������������������












�������������������������


������������������������


���������������������






������������������






������������������



����������������������




��������������������������






���������������������������










��������������������������
������������������������


����������������������


�������������������






����������������




����������������






������������������



���������������������











�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� 