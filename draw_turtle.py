import turtle

def draw_rectangle(x, y, width, height):
    turtle.up()
    turtle.goto(x, y)
    turtle.down()
    turtle.begin_fill()
    for _ in range(2):
        turtle.forward(width)
        turtle.left(90)
        turtle.forward(height)
        turtle.left(90)
    turtle.end_fill()

def drawHeader():
    turtle.color("blue")
    draw_rectangle(-450, 350, 900, 50)
    turtle.up()
    turtle.goto(-225, 330)
    turtle.write("Header", align="center")

def drawFooter():
    turtle.color("green")
    draw_rectangle(-450, -220, 900, 50)
    turtle.up()
    turtle.goto(-225, -250)
    turtle.write("Footer", align="center")

def drawSidebar():
    turtle.color("grey")
    draw_rectangle(-450, -170, 150, 520)
    turtle.up()
    turtle.goto(-375, 150)
    turtle.write("Sidebar", align="center")

def drawBacklogSection():
    turtle.color("lightblue")
    draw_rectangle(-290, -170, 200, 520)
    turtle.up()
    turtle.goto(-190, 150)
    turtle.write("Backlog", align="center")

def drawSprintBoard():
    turtle.color("pink")
    draw_rectangle(-80, -170, 530, 520)
    turtle.up()
    turtle.goto(185, 150)
    turtle.write("SprintBoard", align="center")

# Setup Turtle Screen
turtle.setup(1000, 800)
turtle.speed('fastest')

drawHeader()
drawFooter()
drawSidebar()
drawBacklogSection()
drawSprintBoard()

turtle.hideturtle()
turtle.done()
