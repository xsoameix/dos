# Install

1.  Install DosBox.

        # ubuntu, mint
        $ suto apt-get install dosbox

2.  Mount partition c

        $ mkdir -p /home/yourname/dos/c
        $ dosbox
        Z:\>mount c /home/yourname/dos/c
        Z:\>c:
        C:\>cd src
        C:\>SRC>

3.  Download source code

        $ cd dos/c
        $ mkdir src
        $ cd src
        $ git clone git@github.com:xsoameix/dos.git .

4.  Download the assembler `ml.exe` and linker `link.exe` via the net, place them in `c:\bin`

5.  Assemble, link

        C:\SRC>make hello

6.  Run

        C:\SRC>hello
        hello world.
        C:\SRC>

#   Examples

*   `div_0.asm`: modify the interrupt 0 (and restore it, don't worry)

        C:\SRC>make div_0
        ...
        C:\SRC>div_0
        divide 0.
        C:\SRC>

*   `hack.asm`: the TRS program.

    > Assignment 6: TRS program.
    > Write a TSR program which uses the keyboard interrupt.
    > When a hot key (using ctrl+shift+6 as the hot key) is pressed, the TSR program writes your student ID then your English name in the middle of the console.
    > Note: the TSR program must write directly onto the video RAM of the console instead of using INT calls.

        C:\SRC>make hack
        ...
        C:\SRC>hack
        C:\SRC>(pressed ctrl + shift + 6)
