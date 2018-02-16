#! /usr/bin/python3
import random
from sys import argv

def makeFile():
    fileName = "problemGenerated_ReservesHotel"
    text = "(define (problem " + fileName + ") (:domain ReservesHotel)"
    fileName += ".pddl"
    print(text, file = open(fileName, "w"))
    print(" (:objects \n", end = '', file = open(fileName, "a"))
    qttyHab = int(input("Quantes habitacions te l'hotel ?  ")) + 1

    while (qttyHab < 2):
        print("El numero d'habitacions ha de ser mes gran que 0")
        qttyHab = int(input("Quantes habitacions te l'hotel/hostal ?  ")) + 1
    for x in range(1, qttyHab):
        print("	habitacio_"+str(x)+" ", end='', file=open(fileName, "a"))
    print(" - habitacio \n	", end='', file=open(fileName, "a"))

    # Quantes reserves tens?
    qttyRes = int(input("Quin es el numero de reserves ?  ")) + 1
    while (qttyRes < 2):
        print("El numero de reserves ha de ser mes gran que 0")
        qttyRes = int(input("Quin es el numero de reserves ?  ")) + 1
    for x in range(1, qttyRes):
        print("	reserva_"+str(x)+" ", end='', file=open(fileName, "a"))
    print(" - reserva \n	", end='', file=open(fileName, "a"))

    # Quin es el número del mes?
    numMes = int(input("Quin es el numero del mes en el que es faran les reserves ?  "))
    while (numMes < 1 or numMes > 12):
        print("El numero de mes ha de ser mes gran que 0 i mes petit que 13")
        numMes = int(input("Quin es el numero del mes en el que es faran les reserves ?  "))
    diaMax = 29
    if (numMes == 1 or numMes == 3 or numMes == 5 or numMes == 7 or numMes == 8 or numMes == 10 or numMes == 12):
        diaMax = 31
    if (numMes == 4 or numMes == 6 or numMes == 9 or numMes == 11):
        diaMax = 30
    if (numMes == 2):
        diaMax = 28
    diaMax += 1
    for x in range(1, diaMax):
        print("	dia_"+str(x)+" ", end='', file=open(fileName, "a"))

    print("	- dia", file=open(fileName, "a"))

    print("	)", file=open(fileName, "a"))

    print("	(:init ", file=open(fileName, "a"))

    for x in range (1, diaMax):
        print("		(= (valor-dia dia_"+str(x)+") "+str(x)+") ", file=open(fileName, "a"))
    # Tipus d'habitació
    for x in range (1, qttyHab):
        capacity = int(input("Quina es la capacitat de l'habitacio amb numero " + str(x) + " ?  "))
        while (capacity < 1):
            print("La capacitat d'una habitacio ha de ser com a minim per a una persona")
            capacity = int(input("Quina es la capacitat de l'habitacio amb numero " + str(x) + " ?  "))
        print("		(= (habitacio-capacitat habitacio_"+str(x)+") "+str(capacity)+")", file=open(fileName, "a"))

    for x in range (1, qttyRes):
        capacity= int(input("Per quantes persones es la reserva numero " + str(x) + " ?  "))
        while (capacity < 1):
            print("El numero de persones per reserva ha de ser major de 0")
            capacity= int(input("Per quantes persones es la reserva numero " + str(x) + " ?  "))
        initDia = int(input("Per quin dia ?  "))
        while (initDia < 1 or initDia > diaMax-1):
            print("Ha de ser un dia del calendari")
            initDia = int(input("Per quin dia ?  "))
        initFi  = int(input("Fins a quin dia ?  "))
        while (initDia >= initFi):
            print("El dia de sortida no pot ser anterior o igual al de arribada")
            initFi  = int(input("Fins a quin dia ?  "))
        print("		(= (reserva-capacitat reserva_"+str(x)+") "+str(capacity)+")", file=open(fileName, "a"))
        print("		(= (reserva-diaInici reserva_"+str(x)+") "+str(initDia)+")", file=open(fileName, "a"))
        print("		(= (reserva-diaFi reserva_"+str(x)+") "+str(initFi)+")", file=open(fileName, "a"))

    print("		(= (reserves-ateses) 0)", file=open(fileName, "a"))
    print("	)", file=open(fileName, "a"))
    print("	(:goal(forall (?r - reserva) (atessa ?r)))", file=open(fileName, "a"))
    print("	(:metric minimize (reserves-ateses))", file=open(fileName, "a"))
    print(")", file=open(fileName, "a"))

makeFile()
