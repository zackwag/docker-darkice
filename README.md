# docker-darkice
DarkIce live audio streamer in a docker container

## Example darkice.cfg (place in local directory)

~~~~
# sample DarkIce configuration file, edit for your needs before using
# see the darkice.cfg man page for details

# this section describes general aspects of the live streaming session
[general]
duration        = 0         # duration of encoding, in seconds. 0 means forever
bufferSecs      = 4         # size of internal slip buffer, in seconds

# this section describes the audio input that will be streamed
[input]
device          = hw:0,0    # OSS DSP soundcard device for the audio input
# device          = /dev/dsp  # OSS DSP soundcard device for the audio input
sampleRate      = 44100     # sample rate in Hz. try 11025, 22050 or 44100
bitsPerSample   = 16        # bits per sample. try 16
channel         = 2         # channels. 1 = mono, 2 = stereo

# this section describes a streaming connection to an IceCast2 server
# there may be up to 8 of these sections, named [icecast2-0] ... [icecast2-7]
# these can be mixed with [icecast-x] and [shoutcast-x] sections
[icecast2-0]
# bitrateMode     = abr       # average bit rate
bitrateMode     = vbr       # average bit rate
# format          = vorbis    # format of the stream: ogg vorbis
format          = mp3       # format of the stream: ogg vorbis
# bitrate         = 96        # bitrate of the stream sent to the server
quality         = 0.6       # bitrate of the stream sent to the server
server          = 172.17.0.1
                            # host name of the server
port            = 8000      # port of the IceCast2 server, usually 8000
password        = hackme    # source password to the IceCast2 server
mountPoint      = live      # mount point of this stream on the IceCast2 server
name            = Live      # name of the stream
description     = Live stream
                            # description of the stream
# url             = http://localhost:8000/live.m3u
                            # URL related to the stream
genre           = live      # genre of the stream
public          = no        # advertise this stream?
# localDumpFile   = recording.mp3
                            # local dump file
~~~~

## Example docker-compose

~~~~
  darkice-soundstream:
    image: jwater7/darkice
    container_name: darkice-soundstream
    volumes:
      - "./darkice.cfg:/etc/darkice.cfg:ro"
    privileged: true
    restart: always

  icecast-soundstream:
    image: infiniteproject/icecast
    container_name: icecast-soundstream
    ports:
      - "8000:8000"
    environment:
      - "ICECAST_HOSTNAME=localhost"
      - "ICECAST_SOURCE_PASSWORD=hackme"
      - "ICECAST_ADMIN_PASSWORD=hackme"
      - "ICECAST_RELAY_PASSWORD=hackme"
      - "ICECAST_ADMIN_USERNAME=admin"
      #- "ICECAST_ADMIN_EMAIL="
      #- "ICECAST_LOCATION="
      #- "ICECAST_MAX_CLIENTS="
      #- "ICECAST_MAX_SOURCES="
    restart: always
~~~~

