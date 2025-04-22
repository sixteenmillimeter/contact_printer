---
fontfamily: tgtermes
title: "A Desktop Contact Printer for 16mm Motion Picture Film"
documentclass: article
author:
- name: Matthew McWilliams
  affiliation: sixteenmillimeter.com
  email: hi@mmcwilliams.com
abstract: |
    This paper introduces a design for a small-footprint contact printer for copying 16mm negatives to print stock.
    This free and open-source design can be manufactured using 3D printing and assembled using hobbyist electronic components, metric bolts and lengths of standardized aluminum extrusion.
    All of the design documentation, models for manufacturing and software are to be released freely and openly for public usage.
    The project aims to fill a need for small-scale analog motion picture printmaking capability presented by artist-run film labs and individual filmmakers who are working with film for projection.
    This paper puts forward the explanations behind behind design decisions and the results of tests that were performed during prototyping.
bibliography: sources.bib
csl: citation_style.csl
---

```{=latex}
\begin{center}
```

![Photograph of the contact printer prototype](../img/IMG_8295.jpg){ width=4in height=3in }

```{=latex}
\end{center}
```

# Introduction

The contact printer is a tool used in analog filmmaking that enables negative film to be printed to positive for projection and more generally allows one film media to be copied onto another film media.
In typical usage a camera-original developed negative film strip is sandwiched emulsion-to-emulsion in *contact* with an unexposed, undeveloped print stock strip.
A light shown from behind the negative picture source that passes through it and exposes the negative of its image onto the print stock.
The contact between the two film strips is essential because the direct contact of the picture stocks developed emulsion to the undeveloped emulsion of the print stock ensures that the copy is as sharp as possible.
Any distance between the two will result in an unfocused copy.

```{=latex}
\begin{center}
```

![Illustration of intermittent-motion vs. continuous printers](../img/contact_printer_types.png){ width=4in height=2.66in }

```{=latex}
\end{center}
```

Contact printers can be continuous or intermittent-motion: meaning that they expose each frame individually, pausing for each exposure [@contactpridx8].
This project will create a continuous printer for simplicity.
Intermittent-motion printers require precise movements, more complex lamps or shutter mechanisms and would make this a more complicated DIY project.
This is to be avoided for now.

# Motivations

The use of 16mm film and other small gauge formats has reached a new equilibrium where it is almost no longer used by mid-to-high budget productions aiming for print distribution.
Commercial production companies still use small gauge analog movie film as a capture medium but a vast majority of them that use it only as digital scans and analog film projection is an after thought (if one at all).
Filmmakers that make prints for 16mm projection are a different population of people than they were 100, 50 or even 30 years ago--they make shorter films, they use more alternative techniques and they are working with fewer resources.
Creating a contact printer that is useful to and usable by those artists *now* means acknowledging that they work at a smaller scale and with different requirements.

Contact printers for working with shorter lengths of film and with a small footprint have been made previously but not for many years.
The Uhler Cine Printer provides a great example of a tool that solves the problem just presented and no action would be needed were it still being made today.
Its design was a product of the time it was created and therefore a modern approach is needed to make a contact printer that fulfills the same needs but, for example, won't be cast out of metal in a mass production run.
Still, it provides a guide as an example of a tool built for shorter films and with simple exposure controls.

```{=latex}
\begin{center}
```

![Photograph of the Uhler Cine Printer](../img/Uhler_Cine_Printer.jpeg){ width=4in height=2.66in }

```{=latex}
\end{center}
```

Designing a new contact printer at the same scale and feature complexity as the towering Bell & Howell Model C printer--a machinebuilt to handle thousands of feet of film for printing features with intricate color and fade controls--is not practical or within the engineering capabilities of the authors.
Creating one at the size and scale the Uhler Cine Printer that can be made using rapid prototyping techniques, however, will find a use to many artists.
A small, portable contact printer that can be quickly stored or even mounted vertically on a wall means that artists will not have to sacrifice floor or even table space to own and operate it.

```{=latex}
\begin{center}
```

![Photograph of the Bell and Howell Model C printer](../img/Bell_and_Howell_Model_CL_Printer.png){ width=2.5in height=3in }

```{=latex}
\end{center}
```

# Design Philosophy

This project adopts the RepRap model of using common components--"simple cheap and ubiquitous parts like screws and electric motors" [@reprap-philosophy]--and building the purpose-specific parts around them.
Aluminum extrusion, the same kind used to build 3D printers and CNC machines, provides a stable framing material that is readily available.
Cheap-but-reliably geared DC motors are to provide movement for the transport mechanism.
Open-source electronics platforms, such as the Arduino and the ESP32 microcontrollers, allow for the electronics to be built and modified by hobbyists and amateurs.

A modular design strategy compared to a monolithic one has two theoretical benefits; it can leverage existing components to make the process easier and it can lead to the creation and update of new components that can benefit other projects.
Key common elements of a contact printer are the film-transporting sprocketed roller and the motorized film take-ups.

Designing all the printable hardware in OpenSCAD [@openscad] gives the creators the benefits of working with code-managing tools and using only plaintext files.
The source control software git [@git] provides the ability to make and track changes that update the project incrementally.
Git is a distributed version control software which means that all copies of the design repository contain the entire project history and the entire project can be restored from one copy.
Changes that are made and "committed" to the git repository are stored as "diffs" or just the difference between the new code and the previous state.
This allows for the tracking of changes over time, with notes annotated why they were made and what they address, and provides the ability to roll back changes to earlier versions of the project.

Using a human-readable design format means that even if the software for rendering the printable models no longer exists or no longer works or for some reason cannot be executed, the features of the design can be theoretically preserved and recreated by reading the measurements the code describes.
Dimensions and makeup of each part are stored in such a way with adjacent comments and other semantic signifiers to describe the 3D objects in such a way that a person with the OpenSCAD code printed out on paper could reconstruct or recreate in another CAD software or physically.

In the below code example a cube measuring 4 mm x 5 mm x 3 mm has a cylindrical void with a 1.5 mm radius removed from it via the "difference" boolean operation.

```{=latex}
\begin{center}
```

![Illustration of OpenSCAD code next to a rendered model of what that code produces](../img/openscad_example.png){ width=4in height=2.22in }

```{=latex}
\end{center}
```

The ultimate goal of this project is to create a free and open design that is a platform others can expand on to fulfill their production needs.
The goal is *not* to create a product and take on all of the expectations and economic considerations that endeavor requires.
The licensing of the project allows for the possibility of motivated individuals or organizations to produce and sell the contact printer without any restrictions.
That same license also gives people the ability to create their own modification and release their own design as they see fit.

# SPECTRAL Residency at Filmwerkplaats

Motivation for this contact printer was spurred on by the SPECTRAL project--Spatial, Performative & Expanded Cinematics – Transnational Research at Artist-run Labs [@spectral].
As a part of the SPECTRAL project, Filmwerkplaats proposed a device research topic: creating a DIY contact printer.
In order to fulfill this research proposal the lab hosted a residency with myself, Hrvoje Spudić [@spudic] and Nan Wang [@wang].
We were given time and resources to explore our various topics of research related to contact printing and creating sound prints.
This allowed for tremendous progress to be made on the details of the implementation and, with darkroom access, gave opportunities to run tests on exposure, use of filters and overall film tensioning.

This residency took place during 
The results included a 100 foot sound print made from a Kodak 7222 Double-X negative onto Kodak 3302 print stock, with a soundtrack written directly on the print and a working first draft prototype of this design.
Collaboration with the other residents led to ideas for future work and improved the design as we performed tests collectively.
The possibility of making this platform work as a soundtrack camera was also explored during this session.

Prior to this residency, a very early version of the prototype was presented at the Liason of Independent Filmmakers of Toronto (LIFT) [@lift] during the "Analog Resilience: Film Labs Gathering" [@lift-labs] in May of 2023.
This device was used to create a short silent print during the lab meeting and provided a starting point which was able to be refined during the dedicated period of research.

# The Contact Printer

![Render of the assembled contact printer](../img/contact_printer.svg){ width=5.5in height=3.89in }

## The Electronics

The central processing unit of this machine is an ESP32 development board.
Choosing an ESP32-based microcontroller allows for the use of the complete Arduino toolchain while maintaining the capability to add advanced features at later point in the design without sacrificing memory or performance.
The microcontroller contains radios for Bluetooth Low Energy and Wifi-based connections, so a remote control application is possible.

For the ease of prototyping and reducing the number of parts in the bill of materials, a L298N motor driver module with two (2) channels will be used for the drive and take-up motors.
Because the take-up motors run concurrently and in opposite directions, they share a single channel with their lead wires reversed.
This requires six (6) GPIO pins to run both motor channels with PWM for speed control.
Motivations for the drive motor encoder have been mentioned, but it will require only three (3) GPIO pins and ground on the ESP32 board.
The lamp is driven by connecting a single GPIO pin to the base pin of a TIP120 transistor and setting the ESP32 pin to  `HIGH` or `LOW`.
It will *not* use PWM to control brightness at this stage as explained in the section detailing the lamp.

## The Sprocketed Roller

Sprockets on a cylindrical roller register the two strips of film at the perforations to keep them aligned and in contact at the correct frame positions as they move through the transports.

![Illustration of film registered by sprockets]()

Production of the sprocketed rollers via 3D printing has been made easier and more precise by the advent of SLA resin printing becoming more available and cheap in the recent years leading up to this development process.
Resin printing is capable of resolutions not possible with FDM desktop printing by an order of magnitude.
The ultra-cheap resin printer used in prototyping this sprocketed roller is the Anycubic Mono 4K [@anycubic] which has a Z axis resolution of 10 microns (0.01mm) and a XY resolution of 35 microns (0.035mm).
This can be compared to the resolutions available in the FDM printer used to make this prototype, the Creality Ender 3 [@ender3], which extrudes plastic through a 400 micron (0.4mm) nozzle and has a range of vertical and horizontal resolutions from 100 to 300 microns (0.1mm to 0.3mm).

The reason these resolutions are important is because of the specification for 16mm perforations on film.


![Illustration of the 8-frame sprocketed roller and the 18-frame roller created with the same module]()

Development of this sprocketed drive roller was kick-started by using an existing parametric model[@param-roller] that was designed to replace an 8-frame roller and work on this project was up-streamed into that module so that it may benefit other use cases.
That work has already proven useful to the mcopy [@mcopy] project as the updated module has been used to design a gate compatible with JK optical printers.
Due to the model being parametric, it can be used in designing film transport mechanisms in other, future projects, and additional improvements to the measurements and tolerances will benefit those projects as well.

The roller designed for this project is distinct from a professionally-oriented machine and is similar to the DIY technique of contact printing using a gang sync block and a flashlight or using a modified editing table as a printer.
16mm gauge film has two different pitches of film perforations: short pitches for camera stocks and long pitches for print stocks.
The purpose of this difference is to allow for a camera stock to sit on the inside of a cylindrical roller and the print stock on the outside so that the minute difference in diameter cause the perforations to line up when registered by sprockets.

![Illustration of short and long pitch films correctly wrapped around a sprocketed roller]()

This alignment creates a design constraint for "proper" lamp orientation: it has to come from inside the roller.
Large-scale commercial machines solve for this by having a large wheel that only contains the sprockets rotate next to the light path, letting the film pass against a gate to support the remainder of the material.
Building this on a small scale is possible but onerous.
Using a single wheel driven directly by a motor that both registers the film perforations of both stocks and supports the opposing soundtrack area of the film is possible to build with minimal parts.

Designing a lamp with a light path and gate that sits at or behind where the motor would need to be mounted is possible and becomes a challenge to be discussed in future work.
Due to the modular nature to this design, the choice to not take this approach at the earliest stages does not preclude the creation of a swap-in panel that uses the existing feed and take-up transports. 

## The Drive Motor

The first choice made in this project was to select the type of motor to be used.
between a stepper motor and a regular DC motor.
Choosing a stepper might immediately the overall complexity of the software design and hardware design increases by adding the requirement of a stepper driver and the code to manage it.
We should also consider the essence and purpose of what each type of these motors are: the stepper moves in discrete movements--steps--while regular DC motors merely move; it's either moving or not.
It is possible that there are stepper motor and drivers that can create smooth continuous motion, but as a requirement it potentially increases the hardware cost and the time spent on testing the movement.

To be clear; smooth, consistent motion is preferred when running the print stock past the lamp because uneven motion can create uneven exposure.
Uneven motion past the lamp can manifest as lines in the frame or pulses that occur over multiple frames depending on the type or frequency of the light.
These artifacts can be caused by other factors that will be discussed with the lamp but by focusing this project on producing the cheapest, smoothest motion with the fewest number of parts to assemble we will be avoiding stepper drive motors at first.

A cheap (~$15 USD at the time of writing) DC geared motor with an encoder present an affordable compromise of a choice in drive motor.
With a reasonably-high resolution encoder, this motor can provide speed and position feedback to the control firmware on a per-frame level.
Geared DC motors do have a drawback: there is slack in the gearing system that means that stopping based on encoder feedback is less accurate than with a stepper motor.

The operating speed of the printer is an important target to set in this design that needs to take into account the effects it will have on usability and exposure.
Slower print speeds would allow for greater overall exposure when controlling for lamp brightness but would make for longer print times.
This is not, itself, disqualifying but being able to produce a film with a shorter amount of time in total darkness while printing reduces the overall risk of fogging the unexposed stock and any other flashing errors that can happen during printing.
Aiming for real-time speed (24 fps) enables the future possibility to build a sound camera module for this platform.
Being able to transport film at this speed would make it easier write soundtracks as well as print picture with the same basic machine.

Though this was the decision that was made for the earliest prototypes it will be discussed critically in exploration of future work.

## The Take-up Motors

A contact printer typically requires at least four reels, cores or spools to transport two strips of film.
Film must be driven from one side--the feed--to another side; the take-up where it is wound onto a core or spool.
For this reason only the take-up side *needs* to be motorized.
This reduces the overall cost of the build and removes the need for additional motor-controlling electronics.

The take-up mechanisms for the picture and stock are inspired by a feature in the The Shaffer Linear Processor [@slp]: the magnetic clutch [@slp-clutch].
In principle a magnetic clutch is two parts; one is driven at a constant speed and a second part, secured only by magnets, slips while tension against it is too great to allow it to move.
The design in this project uses 6 mm neodymium magnets on a drive wheel attached to a coupler with a steel washer and a square pegs for film spools and core adapters.

```{=latex}
\begin{center}
```

![Illustration of an exploded view of a take-up magnetic clutch](../img/contact_printer_takeup.svg){ width=3in height=3.98in }

```{=latex}
\end{center}
```

The choice to direct drive the take-up is due to the fact that powerful geared DC motors are cheap and available.
Driving them separately, rather than using a belt, means that the speed can be controlled individually but that they do not need to.
The speed of one take-up can be set to expect a daylight spool but could be adjusted in future work to optimize for a 2 or 3 inch core.

The take-up mechanism was designed as a standalone module that is broken out from the project and lives in its own git repository [@takeup] so that it may be easily included in other projects.
This module has already been used in the mcopy project [@mcopy] as a motorized film take-up and feed system for JK optical printers.
Improvements to the module during the development of either project--catching defects, adding optional features--will benefit the other.

## The Lamp

To start this project the goal is to create a simple, constant light source for a lamp.
Reducing the number of variables in this part of the design reduces the required cognitive load of using the contact printer.
Being able to load film and run it rather than tweak settings a constant-brightness LED-based lamp matches the simplicity the Uhler Cine Printer which had a single bulb that was either dimmed or filtered.

The first lamp consisted of a three (3) 5mm LED and from tests at the Filmwerkplaats residency we determined, through all of our tests, that more light is needed to have exposure headroom to run at the speed we chose.
A design with six (6) 5mm LEDs was in the next iteration of the lamp that also allowed for an adjustable distance--the first prototype had the LEDs fixed.
Assuming perfect light transmission in the second design, this increases the exposure by a stop and allow for more filters to be used in the case of printing onto color stock.
Our tests with color prints indicated that we needed additional filters, which cut exposure, to achieve standard color using these "cool white" LEDs that likely emitted light in the ~6000 Kelvin range (though they were not measured to confirm their precise color).
The solution of raising the brightness of the lamp allows for more color filters to be added before reducing the below the level required by color print stock.

The L298N motor controller module provides a stable 5 volt DC signal that is used for powering the ESP32 and is wired via a transistor to power the lamp.
In theory, the signal provided by the ESP32 to the transistor could be modulated with a PWM channel.
The reason this is being avoided at this stage is that PWM, as in it's name, pulses light to achieve perceptual brightness.
In the case of a continuous contact print, this would mean the light would be, essentially, flashing on and off as the film passed by the gate.
Using a standard Arduino PWM rate of 5 kHz and assuming the printer is running at an ideal 24 fps (24 Hz) means that the LEDs would blink on and off ~208 per frame.
What this *could* result in is 208 distinct lines along the vertical axis of the image.
It's not a presumption in this project that a PWM-modulated lamp is impossible to make with high-enough of a duty rate or with a properly-designed gate, only that it is a more complicated goal for future work.

## The Gate

![Illustration of all four available gates](../img/contact_printer_gates.svg){ width=5.5in height=1.92in }

The gate, being the part of the printer that allows light to pass from the lamp onto the film with a precise mask, is one of the most essential parts of any contact printer design.
Lessons learned through testing the first version of this prototype mean that major changes were needed in the approach to get satisfactory results.
The first version was very compact and simple but sat a few millimeters away from the sprocketed roller and therefore allowed light to be cast across the film media into unintended areas.
The second version is larger and rounded to allow it to sit as close as possible to the film without impeding its motion.

```{=latex}
\begin{center}
```

![Illustration of the initial approach to the gate next to the first major revision of the gate design](../img/contact_printer_gate_comparison.svg){ width=4in height=3.30in }

```{=latex}
\end{center}
```

In order to maintain the sharpest possible mask the gate needs to be close to the moving film material without scratching or damaging it.
Because the strips of film move past the gate along the top and bottom axis (relative to the film image as it's viewed) what the sharpness and accuracy of the gate determines the quality and selection of the horizontal area of the film--when projecting the resulting image.
Put another way; when the mask is inaccurate it affects the width or sides of an image and when it is not sharp there can be an unintentional bleed from one area to another.

![Illustration of the effects of inaccurate or non-sharp gates]()

Being able to control what selected area along the horizontal axis of the image gets exposed is important when printing with soundtracks.
For a print to be made with sound the gate must allow for a clean separation between the picture area and the soundtrack area of the film.
Sound bleeding into the picture area can affect one side of the image and image bleeding into the soundtrack area can cause a 24Hz hum or other distortion to the audio.
For this reason the standard picture gate and the soundtrack gate should be able to allow light from the lamp to pass onto areas of the film stock that they isolate from one another.

![Illustration of the picture and soundtrack gates side by side]()

An example process for making a print with an image and a soundtrack negative would be to run the unexposed, undeveloped print stock with the negative film containing the negative while using a picture gate and then rewinding the print stock and running it again with the soundtrack negative and the soundtrack gate.
This would first expose the picture onto the print stock and then, without developing, add the soundtrack to *only* the soundtrack area of the print.
Then it could be developed and projected.
It is a relatively simple process but it requires precision in the gates to ensure that the areas the two gates expose are complimentary and not interfering to one another.

## The Frame

Within reason, the aluminum frame for this project is resizable.
The first draft of the original prototype was made to support 100 foot daylight spools and was 300 mm by 175 mm (11.8" x 6.9").
This was changed increase the dimensions to allow for 400 foot reels and is now 400 mm by 260 mm (15.75" x 10.25").
Being able to reduce or increase the area of the frame is one way to make it easier to modify and customize tools built using this platform.
There is nothing preventing the creation of a version of this printer with a much larger footage capacity by expanding the frame even further.

Aluminum extrusion as a choice for building DIY machines has proven to be effective for desktop 3D printers and CNC machines.
There is general availability of common gauges and profiles and aluminum can be cut by hand or with typical shop equipment.
For these prototypes, lengths of aluminum 2020 T-slot profile extrusion were cut either by hand using a hacksaw or by drop saw.
As a framing material it is light, sturdy and holds up to substantial forces when secured with panels and other brackets.

![Illustration of the 2020 aluminum extrusion frame with lengths separated](../img/contact_printer_frame.svg){ width=5.5in height=2.5in }

It would be possible to increase the rigidity, if needed, by adding additional intermediary crossing lengths but for this prototype a total of six (6) lengths connected by five (5) panels and eight (8) corner brackets has been sturdy enough for all tests.

## The Firmware

The Arduino platform uses a subset of C++ which has the benefits of being approachable and easy to use while at the same time preserving the functionalities of the full C++ language for when they are needed.
The project is built with an object-oriented programming style that allows for abstraction over the functionality of the physical hardware and other features at the class level.
This approach serves the project's larger goal to leverage modularity by making use of pre-existing classes and creating reusable ones for other projects.

The firmware can be compiled and uploaded using the Arduino IDE [@arduino-ide] or the arduino-cli [@arduino-cli] application using the "esp32:esp32:esp32" FBQN (Fully Qualified Board Name).
The code can be compiled *without* the ESP32 Arduino libraries and just the standard AVR libraries but the GPIO usage and LED PWM channel usage is such that it would have to be refactored to work on another board.
Had this project targeted a different Arduino board from the start there would be limitations in the PWM duty rates of the motors and the ability to add network features.

Functionality is abstracted into three classes: the high-level "ContactPrinter" class which then imports the "DriveMotor" and "Lamp" classes.
There is a stub for the HTTP networking features named "WebGUI" which does not do anything but host a placeholder page at this time.
The ContactPrinter class manages the take-up motors directly but the DriveMotor class is broken out into its own abstraction because it is expected to stabilize and manage the speed of the drive motor more accurately with feedback from the drive motors encoder and also keeps track of the number of frames passed using the same encoder data.
The Lamp class, at this time, simply turns the contact printer lamp on or off using a method.

The initial release of the firmware simply starts the printer when a button is pressed, turns the lamp on after 24 frames pass and stops it when that same button is pressed.
Additional features, to be discussed in future work, can allow for the adjustment of several behaviors; changing the number of frames that pass before the lamp is struck, running only for a set number of frames, reducing the speed of the printer, etc.

# Future Work

## Interfaces

Physical interfaces are another area of future expansion and development.
Requests have been made, for example, to add a dial for controlling lamp brightness.
This was avoided in the prototyping phase because it would add parts to the bill of materials and create additional potential points of failure in the wiring.

## Sound

Creating a sound camera from this platform is 

## Color Lamp Control

## Multi-format

Kinograph multi-format sprocketed roller.

### Research Supporters

![](../img/EN_FundedbytheEU_RGB_POS.png){ width=5.5in height=1.2in }

### References

---
refs: |
   ::: {#refs}
   :::
...

