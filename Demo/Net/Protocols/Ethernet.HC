class CEthernetFrame
{
  U8 source_address[6];
  U8 padding[2];
  U8 destination_address[6];
  U16 ethertype;

  U8 *data;

  I64 length;
};

class CEthernetGlbls
{
  U8 ethernet_null[6];
  U8 ethernet_broadcast[6];
} ethernet_globals;


U0 EthernetGlblsInit()
{
  I64 i;
  for (i = 0; i < 6; i++)
  {
    ethernet_globals.ethernet_null[i] = 0;
    ethernet_globals.ethernet_broadcast[i] = 0xFF;
  }
}

//TODO: check length , figure out the length+4
U0 EthernetFramePrs(CEthernetFrame *frame_out, U8 *frame, U16 length)
{//TODO: Check length ! We need to figure out what
  //lengths are appropriate
  //Shrine also says MemCpy has a
  //high overhead. Almost tempted to say that means that a lot
  //of the current adam should be done with less extra allocation
  //altogether, more passing.
  //In practice, MemCpy causes the most slowdown on bare-metal.
  NetLog("ETHERNET FRAME PARSE: Parsing frame, copying out to frame_out param.");
  MemCpy(frame_out->destination_address, frame, MAC_ADDRESS_LENGTH);
  MemCpy(frame_out->source_address, frame + MAC_ADDRESS_LENGTH, MAC_ADDRESS_LENGTH);
  frame_out->ethertype = frame[ETHERNET_ETHERTYPE_OFFSET + 1] |
      frame[ETHERNET_ETHERTYPE_OFFSET] << 8;
  frame_out->data = frame + ETHERNET_DATA_OFFSET;
  frame_out->length = length - ETHERNET_MAC_HEADER_LENGTH -
      4; // He has a comment literally just saying "??". + or - 4?
}

EthernetGlblsInit;
