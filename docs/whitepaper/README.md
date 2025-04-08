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

![Photograph of the first contact printer prototype at Filmwerkplaats]()

# Introduction

The contact printer is a tool used in analog filmmaking that enables negative film to be printed to positive for projection and more generally allows one film media to be copied onto another film media.
In typical usage a camera-original developed negative film strip is sandwiched emulsion-to-emulsion in *contact* with an unexposed, undeveloped print stock strip.
A light shown from behind the negative picture source that passes through it and exposes the negative of its image onto the print stock.
The contact between the two film strips is essential because the direct contact of the picture stocks developed emulsion to the undeveloped emulsion of the print stock ensures that the copy is as sharp as possible.
Any distance between the two will result in an unfocused copy.

Contact printers can be continuous or intermittent-motion: meaning that they expose each frame individually, pausing for each exposure.
This project will create a continuous printer for simplicity.
Intermittent-motion printers require precise movements, more complex lamps or shutter mechanisms and would make this a more complicated DIY project.
This is to be avoided; for now.

![Illustration of intermittent-motion vs. continuous printers]()

# Motivations

The use of 16mm film and other small gauge formats has reached a new equilibrium where it is almost no longer used by mid-to-high budget productions aiming for print distribution.
Commercial production companies still use small gauge analog movie film as a capture medium but a vast majority of them that use it only as digital scans and analog film projection is an after thought (if one at all).
Filmmakers that make prints for 16mm projection are a different population of people than they were 100, 50 or even 30 years ago--they make shorter films, they use more alternative techniques and they are working with fewer resources.
Creating a contact printer that is useful to and usable by those artists *now* means acknowledging that they work at a smaller scale and with different requirements.

Contact printers for working with shorter lengths of film and with a small footprint have been made previously but not for many years.
The Uhler Cine Printer provides a great example of a tool that solves the problem just presented and no action would be needed were it still being made today.
Its design was a product of the time it was created and therefore a modern approach is needed to make a contact printer that fulfills the same needs but, for example, won't be cast out of metal in a mass production run.
Still, it provides a guide as an example of a tool built for shorter films and with simple exposure controls.

![Photograph of the Uhler Cine Printer]()

Designing a new contact printer at the same scale and feature complexity as the towering Bell & Howell Model C printer--a machinebuilt to handle thousands of feet of film for printing features with intricate color and fade controls--is not practical or within the engineering capabilities of the authors.
Creating one at the size and scale the Uhler Cine Printer that can be made using rapid prototyping techniques, however, will find a use to many artists.
A small, portable contact printer that can be quickly stored or even mounted vertically on a wall means that artists will not have to sacrifice floor or even table space to own and operate it.

![Photograph of the Bell & Howell Model C printer]()

# Design Philosophy

This project adopts the RepRap model of using common components--"simple cheap and ubiquitous parts like screws and electric motors" [@reprap-philosophy]--and building the purpose-specific parts around them.
Aluminum extrusion, the same kind used to build 3D printers and CNC machines, provides a stable framing material that is readily available.
Cheap-but-reliably geared DC motors are to provide movement for the transport mechanism.
Open-source electronics platforms, such as the Arduino and the ESP32 microcontrollers, allow for the electronics to be built and modified by hobbyists and amateurs.

A modular design strategy compared to a monolithic one has two theoretical benefits; it can leverage existing components to make the process easier and it can lead to the creation and update of new components that can benefit other projects.
Key common elements of a contact printer are the film-transporting sprocketed roller and the motorized film takeups.

Designing all the printable hardware in OpenSCAD [@openscad] gives the creators the benefits of working with code-managing tools and using only plaintext files.
The source control software git [@git] provides the ability to make and track changes that update the project incrementally.
Git is a distributed version control software which means that all copies of the design repository contain the entire project history and the entire project can be restored from one copy.
Changes that are made and "committed" to the git repository are stored as "diffs" or just the difference between the new code and the previous state.
This allows for the tracking of changes over time, with notes annotated why they were made and what they address, and provides the ability to roll back changes to earlier versions of the project.

![Illustration of OpenSCAD code next to a rendered model of what that code produces]()

Using a human-readable design format means that even if the software for rendering the printable models no longer exists or no longer works or for some reason cannot be executed, the features of the design can be theoretically preserved and recreated by reading the measurements the code describes.
Dimensions and makeup of each part are stored in such a way with adjacent comments and other semantic signifiers to describe the 3D objects in such a way that a person with the OpenSCAD code printed out on paper could reconstruct or recreate in another CAD software or physically.

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

The results of this residency included a 100 foot sound print made from a Kodak 7222 Double-X negative onto Kodak 3302 print stock, with a soundtrack written directly on the print and a working first draft prototype of this design.
Collaboration with the other residents led to ideas for future work and improved the design as we performed tests collectively.
The possibility of making this platform work as a soundtrack camera was also explored during this session.

# The Contact Printer

## The Sprocketed Roller

Sprockets on a cylindrical roller register the two strips of film at the perforations to keep them aligned and in contact at the correct frame positions as they move through the transports.

![Illustration of film registered by sprockets]()

Production of the sprocketed rollers via 3D printing has been made easier and more precise by the advent of SLA resin printing becoming more available and cheap in the recent years leading up to this development process.
Resin printing is capable of resolutions not possible with FDM desktop printing by an order of magnitude.
The ultra-cheap resin printer used in prototyping this sprocketed roller is the Anycubic Mono 4K [@anycubic] which has a Z axis resolution of 10 microns (0.01mm) and a XY resolution of 35 microns (0.035mm).
This can be compared to the resolutions available in the FDM printer used to make this prototype, the Creality Ender 3 [@ender3], which extrudes plastic through a 400 micron (0.4mm) nozzle and has a range of vertical and horizontal resolutions from 100 to 300 microns (0.1mm to 0.3mm).

![Illustration of the 8-frame sprocketed roller and the 18-frame roller created with the same module]()

Development of this sprocketed drive roller was kickstarted by using an existing parametric model[@param-roller] that was designed to replace an 8-frame roller and work on this project was upstreamed into that module so that it may benefit other use cases.
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
Due to the modular nature to this design, the choice to not take this approach at the earliest stages does not preclude the creation of a swap-in panel that uses the existing feed and takeup transports. 

## The Drive Motor

The first choice made in this project was to select the type of motor to be used.
between a stepper motor and a regular DC motor.
Choosing a stepper might immediately the overall complexity of the software design and hardware design increases by adding the requirement of a stepper driver and the code to manage it.
We should also consider the essence and purpose of what each type of these motors are: the stepper moves in discrete movements--steps--while regular DC motors merely move; it's either on or off.
It is possible that there are stepper motor and drivers that can create smooth continuous motion, but as a requirement it potentially increases the hardware cost and the time spent on testing the movement.

To be clear; smooth, even motion is preferred when running the print stock past the lamp because uneven motion can create uneven exposure.
Uneven motion past the lamp can manifest as lines in the frame or pulses that occur over multiple frames depending on the type or frequency of the light.
These artifacts can be caused by other factors that will be discussed with the lamp but by focusing this project on producing the cheapest, smoothest motion with the fewest number of parts to assemble we will be avoiding stepper drive motors at first.

A cheap (~$15 USD at the time of writing) DC geared motor with an encoder present an affordable compromise of a choice in drive motor.
With a reasonably-high resolution encoder, this motor can provide speed and position feedback to the control firmware at a per-frame level.

Geared DC motor drawbacks : stopping has slack in system
Using a PWM motor driver and 

The operating speed of the printer is an important target to set in this design that needs to take into account the effects it will have on usability and exposure.
Slower print speeds would allow for greater overall exposure when controlling for lamp brightness but would make for longer print times.
This is not, itself, disqualifying but being able to produce a film with a shorter amount of time in total darkness while printing reduces the overall risk of fogging the unexposed stock and any other flashing errors that can happen during printing.
Aiming for real-time speed (24 fps) enables the future possibility to build a sound camera module for this platform.
Being able to transport film at this speed would make it easier write soundtracks as well as print picture with the same basic machine.

Though this was the decision that was made for the earliest prototypes it will be discussed critically in exploration of future work.

## The Takeup Motors

A contact printer typically requires at least four reels, cores or spools to transport two strips of film.
Film must be driven from one side--the feed--to another side; the takeup.

The takeup motors for the picture and stock are inspired by a feature in the The Shaffer Linear Processor [@slp]: the magnetic clutch [@slp-clutch].

![Illustration of an exploded view of a takeup magnetic clutch]()

The choice to direct drive the takeup is due to the fact that powerful geared DC motors are cheap and available.
Driving them separately, rather than using a belt, means that the speed can be controlled individually.
The speed of one takeup can be set to expect a 3 inch core but

## The Lamp

To start this project the goal is to create a simple, constant lamp.
Reducing the number of variables in the light source reduces the required cognitive load of using the contact printer.
Being able to load film and run it rather than tweak settings, a simple, constant LED-based lamp matches the simplicity the Uhler Cine Printer which had a single bulb that was either dimmed or filtered.

The first lamp consisted of a three (3) 5mm LED and from tests at the Filmwerkplaats residency we determined, through all of our tests, that there needs to be more light to have exposure headroom to run at the speed we chose.

Design with six 5mm LEDs was in the next iteration of the lamp that also allowed for an adjustable distance.
Assuming perfect light transmission in the second design, this would increase the exposure by a stop and allow for more filters to be used in the case of printing onto color stock.
Our tests with color prints indicated that we needed additional filters, which cut exposure, to achieve standard color using the 

## The Gate

The gate, being the part of the printer that allows light to pass from the lamp onto the film with a precise mask, is one of the most essential parts of any contact printer design.
Lessons learned through testing the first version of this prototype mean that major changes were needed in the approach to get satisfactory results.


![Illustration of the initial approach to the gate next to the first major revision of the gate design]()

In order to maintain the sharpest possible mask the gate needs to be close to the moving film material without scratching or damaging it.
Because the strips of film move past the gate along the top and bottom axis (relative to the film image as it's viewed) what the sharpness and accuracy of the gate determines the quality and selection of the horizontal area of the film--when projecting the resulting image.
Put another way; when the mask is inaccurate it affects the width or sides of an image and when it is not sharp there can be an unintentional bleed from one area to another.

![Illustration of the effects of inaccurate or non-sharp gates]()

Being able to control what selected area along the horizontal axis of the image gets exposed is important when printing with soundtracks.
For a print to be made with sound the gate must allow for a clean separation between the picture area and the soundtrack area of the film.
Sound bleeding into the picture area can affect one side of the image and image bleeding into the soundtrack area can cause a 24Hz hum or other distortion to the audio.
For this reason the standard picture gate and the soundtrack gate should be able to allow light from the lamp to pass onto areas of the film stock that they isolate from one another.

![]()

An example process for making a print with an image and a soundtrack negative would be to run the unexposed, undeveloped print stock with the negative film containing the negative while using a picture gate and then rewinding the print stock and running it again with the soundtrack negative and the soundtrack gate.
This would first expose the picture onto the print stock and then, without developing, add the soundtrack to *only* the soundtrack area of the print.
Then it could be developed and projected.
It is a relatively simple process but it requires precision in the gates to ensure that the areas the two gates expose are complimentary and not interfering to one another.

## The Frame

Within reason, the frame for this project should be resizable.
The first draft of the original prototype was made to support 100 foot daylight spools and the first change was to increase the dimensions to allow for 400 foot reels.
Being able to reduce or increase the area of the frame is one way to make it easier to modify tools built using this platform.

Aluminum extrusion as a choice for building DIY machines has proven to be effective for desktop 3D printers and CNC machines.
There is general availability of common gauges and profiles and aluminum can be cut by hand or with typical shop equipment.
For these prototypes, lengths of aluminum 2020 T-slot profile extrusion were cut either by hand using a hacksaw or by drop saw.
As a framing material it is light, sturdy and holds up to substantial forces when secured with panels and other brackets.

![Illustration of the 2020 aluminum extrusion frame with lengths separated]()

It would be possible to add additional rigidity if needed by adding additional lengths but for this prototype a total of six (6) lengths connected by five (5) panels and eight (8) corner brackets has been st


## The Electronics

The central processing unit of this machine is an ESP32 development board.
Choosing an ESP32-based microcontroller allows for the use of the complete Arduino toolchain while maintaining the capability to add advanced features at later point in the design without sacrificing memory or performance.
The microcontroller contains radios for Bluetooth Low Energy and Wifi-based connections, so a remote control application is possible.

For the ease of prototyping and reducing the number of parts in the bill of materials, a L298N motor driver module with two (2) channels will be used for the drive and takeup motors.
Because the takeup motors run concurrently and in opposite directions, they share a single channel with their lead wires reversed.
This requires six (6) GPIO pins to run both motor channels with PWM for speed control.
Motivations for the drive motor encoder have been mentioned, but it will require only three (3) GPIO pins and ground on the ESP32 board.
The lamp is driven by connecting a single GPIO pin to the base pin of a TIP120 transistor and setting the ESP32 pin to  `HIGH` or `LOW`.
It will *not* use PWM to control brightness at this stage.

## The Firmware

The Arduino platform uses a subset of C++ which has the benefits of being approachable and easy to use while at the same time preserving all the functionalities of the full C++ language for when they are needed.
The project is built with an object-oriented programming style that allows for abstraction over the functionality of the physical hardware and other features at the class level.
This approach serves the project's larger goal to leverage modularity by making use of pre-existing classes and creating reusable ones for other projects.
The initial release of the firmware will 


# Assembly

## Printing the Components

PLA or PETG for most parts.
This may seem obvious but just to be clear: dark colored plastics reflect less light.
Printing parts in all black plastic is an easy way to make parts with the lowest possible reflective areas close to the 

## Assembling the Frame

Cut with miter box

Cut with drop saw


## Assembling the Electronics

# Operation



# Future Work

## Interfaces

Physical interfaces are another area of future expansion and development.
Requests have been made, for example, to add a dial for controlling lamp brightness.
This was avoided in the prototyping phase because it would add parts to the bill of materials and create additional potential points of failure in the wiring.

## Sound

## Color Lamp Control



## Multi-format

Kinograph multi-format sprocketed roller.

### References

---
refs: |
   ::: {#refs}
   :::
...