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
    It aims to fill a need for small-scale printing capability presented by artist-run film labs and individual filmmakers who are working with analog motion picture film for projection.
bibliography: sources.bib
csl: citation_style.csl
---

![Photograph of the first contact printer prototype at Filmwerkplaats]()

# Introduction

The contact printer is a tool for analog filmmaking that enables negative film to be printed to positive for projection and more generally allows film media to be copied onto other film stocks.
In typical usage a camera-original, developed negative film strip is sandwiched emulsion-to-emulsion in *contact* with an unexposed, undeveloped print stock.
A light shown from behind the negative, or picture source, exposes the image onto the print stock.

Contact printers can be continuous or intermittent-motion: meaning that they expose each frame individually, pausing for each exposure.
This project will create a continuous printer for simplicity.
Intermittent-motion printers require precise movements, more complex lamps or shutter mechanisms and would make this a needlessly-complicated DIY project.

![Illustration of intermittent-motion vs. continuous printers]()

# Motivations

The use of 16mm film and other small gauge formats has reached a new equilibrium where it is almost no longer used in mid-to-high budget productions aiming for print distribution.
Big production companies still use analog movie film as a capture medium but a vast majority of them that use it go to digital scans and real film projection is an after thought (if one at all).
Filmmakers that make prints for 16mm projection are a different population of people than 100, 50 or even 30 years ago--they make shorter films, they use more alternate techniques and they are working with fewer resources.
Creating a contact printer that is useful to and usable by those artists *now* means acknowledging that they work at a smaller scale and with different requirements.

Contact printers for working with shorter lengths of film and with a small footprint have been made previously but not for many years.
The Uhler Cine Printer provides a great example of a tool that solves the problem just presented and no action would be needed were it still being made today.
Its design was a product of the time it was created and therefore a modern approach is needed to make a contact printer that fulfills the same needs but, for example, won't be cast out of metal in a mass production run.
Still, it provides a guide as an example of a tool built for shorter films and with simple exposure controls.

# Design Philosophy

Designing a new contact printer at the same scale and feature complexity as the towering Bell & Howell Model C printer that was built to handle thousands of feet of film for printing features with intricate color and fade controls is not practical or within the engineering capabilities of the authors.
Creating one at the scale the Uhler Cine Printer that can be made using rapid prototyping techniques, however, will find a use to many artists.
A small, portable contact printer that can be quickly stored or even mounted vertically on a wall means that artists will not have to sacrifice floor or even table space to own and operate it.

![Photograph of the Bell & Howell Model C printer next to the Uhler Cine Printer]()

This project adopts the RepRap model of using common components--"simple cheap and ubiquitous parts like screws and electric motors" [@reprap-philosophy]--and building the purpose-specific parts around them.
Aluminum extrusion, the same kind used to build 3D printers and CNC machines, provides a stable framing material that is readily available.
Cheap-but-reliably geared DC motors are to provide movement for the transport mechanism.
Open-source electronics platforms, such as the Arduino and the ESP32 microcontrollers, allow for the electronics to be built and modified by hobbyists and amateurs.

A modular design strategy compared to a monolithic one has two theoretical benefits; it can leverage existing components to make the process easier and it can lead to the creation and update of new components that can benefit other projects.
Key common elements of a contact printer are the film-transporting sprocketed roller and the motorized film takeups.

Designing all the printable hardware in OpenSCAD [@openscad] gives the creator the benefits of working with code-managing tools and using only plaintext files.
The source control software git [@git] provides the ability to make and track changes that update the project incrementally.
Changes that are made and "committed" to the git repository are stored as "diffs" or just the difference between the new code and the previous state.
This allows for the tracking of changes over time, with notes annotated why they were made and what they address, and provides the ability to roll back changes to earlier versions of the project.
Many of the illustrations and renderings in this paper were made by rolling back to earlier stages in the design process and using exactly what was represented in the code on specific dates or before certain changes were made.

Using a human-readable design format means that even if the software for rendering the printable models no longer exists or no longer works or for some reason cannot be executed, the features of the design can be theoretically preserved and recreated by reading the measurements the code describes.
Dimensions and makeup of each part are stored in such a way with adjacent comments and other semantic signifiers to describe the 3D objects in such a way that a person with the OpenSCAD code printed out on paper could reconstruct or recreate in another CAD software.

The ultimate goal of this project is to create a free and open design that is a platform that others can expand on to fulfill their production needs.
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

The speed of the printer is an important factor in this design that affects usability and exposure.
Slower speeds would allow for more overall exposure when controlling for lamp brightness but would make for longer print times.
Targeting the capability for real time speeds (24 fps) preserves the ability to build a sound camera module and expand this platform to write soundtracks as well as print picture.

The first choice made in this project was to select between a stepper motor and a regular DC motor.
By choosing a stepper, immediately the overall complexity of the software design and hardware design increases by adding the requirement of a stepper driver and the code to manage it.
There is also the consideration of what each of these styles of motors are: a stepper moves in discrete movements while a regular DC merely moves.
It is possible that there are stepper motor and driver that moves continuously, but each of those requirements increases the cost of making that choice both in the quality of the hardware required and the time spent on testing the movement.

A cheap (~$10 at the time of writing) DC geared motor with an encoder present an affordable compromise of a choice in drive motor.
With a reasonably-high resolution encoder, this motor can provide speed and position feedback to the control firmware at a per-frame level.

Geared DC motor drawbacks : stopping has slack in system

24fps is the target because the platform could be used, theoretically, to build a sound camera.

## The Lamp

The initial design for the lamp is to be simple and constant.
By reducing the number of variables on the light source of this printer

Initial tests of a three 5mm LED unit indicated that there needs to be more light to have exposure headroom.

Design with six 5mm LEDs was in the next iteration of the lamp that also allowed for an adjustable distance.
Assuming perfect light transmission in the new design, this would increase the exposure by a stop and 

## The Takeup Motors

A contact printer typically requires at least four reels, cores or spools to transport two strips of film.
Film must be driven from one side--the feed--to another side; the takeup.

The takeup motors for the picture and stock are inspired by a feature in the The Shaffer Linear Processor [@slp]: the magnetic clutch [@slp-clutch].

The choice to direct drive the takeup is due to the fact that powerful geared DC motors are cheap and available.
Driving them separately, rather than using a belt, means that the speed can be controlled individually.
The speed of one takeup can be set to expect a 3 inch core but

## The Frame

Scalable.
The original prototype was made to support 100 foot daylight spools

By increasing the dimensions of the frame, the

## The Electronics

The central processing unit of this machine is an ESP32 development board.
Choosing an ESP32-based microcontroller allows for the use of the complete Arduino toolchain while maintaining the capability to add advanced features at later point in the design.
The microcontroller contains radios for Bluetooth Low Energy and Wifi-based connections, so a remote control application is possible.

## The Firmware

The Arduino platform uses a subset of C++ which has the benefits of being approachable and easy to use while at the same time preserving all the functionalities of the full C++ language for when they are needed.
The project is built with an object-oriented programming style that allows for abstraction over the functionality of the physical hardware and other features at the class level.
This approach serves the project's larger goal to leverage modularity by making use of pre-existing classes and creating reusable ones for other projects.
The initial release of the firmware will 




# Assembly

## Printing the Components

PLA or PETG for most parts.
This may seem obvious but just to be clear: dark colored plastics reflect less light.
Printing parts in all black plastic best ensures that

## Assembling the Frame

Cut with miter box

Cut with drop saw


## Assembling the Electronics

# Operation



# Future Work

## Interfaces

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