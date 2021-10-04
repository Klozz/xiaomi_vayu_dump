set -x
# $1: device for output
#     spk: speaker
#     rcv: receiver
#     spk_hp: speaker high power
#     us: ultrasound

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk
# rcv.wav:-4.5dbfs   spk: -4.8dbfs  ultra: -4.5dbfs  spk_hp:-1.8dbfs

function enable_speaker
{
    echo "enabling speaker"
    tinymix 'QUAT_MI2S_RX Channels' 'Two'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
    #tinymix 'TAS256X RX MODE RIGHT' 'Speaker'
    tinymix 'TAS256X ASI1 SEL RIGHT' 'Right'
    tinymix 'TAS256X ASI1 SEL LEFT' 'Left'
    tinymix 'TAS256X ASI Right Switch' '1'
    tinymix 'TAS256X ASI Left Switch' '1'
    tinymix 'TAS256X PLAYBACK VOLUME LEFT' '50'
    tinymix 'TAS256X PLAYBACK VOLUME RIGHT' '50'
    sleep 1
}


function disable_speaker
{
    echo "disabling speaker"
    tinymix 'QUAT_MI2S_RX Channels' 'Two'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
    #tinymix 'TAS256X RX MODE RIGHT' 'Speaker'
    tinymix 'TAS256X ASI1 SEL RIGHT' 'I2C offset'
    tinymix 'TAS256X ASI1 SEL LEFT' 'I2C offset'
    tinymix 'TAS256X ASI Right Switch' '0'
    tinymix 'TAS256X ASI Left Switch' '0'
    tinymix 'TAS256X PLAYBACK VOLUME LEFT' '55'
    tinymix 'TAS256X PLAYBACK VOLUME RIGHT' '55'
}

function enable_speaker_top
{
    echo "enabling top speaker"
    tinymix 'QUAT_MI2S_RX Channels' 'One'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'TAS256X RX MODE LEFT' 'Speaker'
    tinymix 'TAS256X ASI1 SEL LEFT' 'Left'
    tinymix 'TAS256X ASI Left Switch' '1'
    tinymix 'TAS25XX_ALGO_BYPASS' 'TRUE'
    tinymix 'TAS256X PLAYBACK VOLUME LEFT' '55'
    sleep 1
}


function disable_speaker_top
{
    echo "enabling top speaker"
    tinymix 'QUAT_MI2S_RX Channels' 'Two'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'TAS256X RX MODE LEFT' 'Speaker'
    tinymix 'TAS256X ASI1 SEL LEFT' 'I2C offset'
    tinymix 'TAS256X ASI Left Switch' '0'
    tinymix 'TAS25XX_ALGO_BYPASS' 'FALSE'
    tinymix 'TAS256X PLAYBACK VOLUME LEFT' '55'
}

function enable_speaker_bot
{
    echo "enabling bottom speaker"
    tinymix 'QUAT_MI2S_RX Channels' 'One'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'TAS256X ASI1 SEL RIGHT' 'Right'
    tinymix 'TAS256X ASI Right Switch' '1'
    tinymix 'TAS25XX_ALGO_BYPASS' 'TRUE'
    tinymix 'TAS256X PLAYBACK VOLUME RIGHT' '52'
    sleep 1
}

function disable_speaker_bot
{
    echo "enabling bottom speaker"
    tinymix 'QUAT_MI2S_RX Channels' 'Two'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'TAS256X ASI1 SEL RIGHT' 'I2C offset'
    tinymix 'TAS256X ASI Right Switch' '0'
    tinymix 'TAS25XX_ALGO_BYPASS' 'FALSE'
    tinymix 'TAS256X PLAYBACK VOLUME RIGHT' '55'
}

function enable_receiver
{
    echo "enabling receiver"
    tinymix 'QUAT_MI2S_RX Channels' 'One'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'TAS256X RX MODE LEFT' 'Receiver'
    tinymix 'TAS256X ASI1 SEL LEFT' 'Left'
    tinymix 'TAS256X ASI Left Switch' '1'
    tinymix 'TAS25XX_ALGO_BYPASS' 'TRUE'
    tinymix 'TAS256X PLAYBACK VOLUME LEFT' '52'
    sleep 1
}

function disable_receiver
{
    echo "enabling receiver"
    tinymix 'QUAT_MI2S_RX Channels' 'Two'
    tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'TAS256X RX MODE LEFT' 'Speaker'
    tinymix 'TAS256X ASI1 SEL LEFT' 'I2C offset'
    tinymix 'TAS256X ASI Left Switch' '0'
    tinymix 'TAS25XX_ALGO_BYPASS' 'FALSE'
    tinymix 'TAS256X PLAYBACK VOLUME LEFT' '55'
}

function enable_headphone
{
    echo "enabling headphone"
    tinymix 'SLIM RX0 MUX' 'AIF1_PB'
    tinymix 'SLIM RX1 MUX' 'AIF1_PB'
    tinymix 'SLIM_0_RX Channels' 'Two'
    tinymix 'RX INT1_1 MIX1 INP0' 'RX0'
    tinymix 'RX INT2_1 MIX1 INP0' 'RX1'
    tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
    tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX INT2 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'COMP1 Switch' 1
    tinymix 'COMP2 Switch' 1
    sleep 1
}

function disable_headphone
{
    echo "disabling headphone"
    tinymix 'SLIM RX0 MUX' 'ZERO'
    tinymix 'SLIM RX1 MUX' 'ZERO'
    tinymix 'SLIM_0_RX Channels' 'One'
    tinymix 'RX INT1_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT2_1 MIX1 INP0' 'ZERO'
    tinymix 'SLIMBUS_0_RX Audio Mixer MultiMedia1' 0
}

if [ "$1" = "spk" ]; then
#    enable_speaker
#    filename=/vendor/etc/spk.wav
    enable_speaker_bot
    filename=/vendor/etc/spk.wav
elif [ "$1" = "top-spk" ]; then
    enable_speaker_top
    filename=/vendor/etc/top_spk.wav
elif [ "$1" = "bot-spk" ]; then
    enable_speaker_bot
    filename=/vendor/etc/spk.wav
elif [ "$1" = "rcv" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "rcv_hp" ]; then
    enable_headphone
    filename=/vendor/etc/rcv_hp.wav
else
    echo "Usage: playback.sh device; device: spk bot-spk rcv rcv_hp"
fi

echo "start playing"
tinyplay $filename

if [ "$1" = "spk" ]; then
#    disable_speaker
    disable_speaker_bot
elif [ "$1" = "top-spk" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv" ]; then
    disable_receiver
elif [ "$1" = "rcv_hp" ]; then
    disable_headphone
fi

exit 0
