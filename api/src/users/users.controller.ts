import { Body, Controller, Get, Injectable, Param, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { createUserDto } from './dto/create-user.dto';
import { User } from './entities/user.entity';
import { UsersService } from './users.service';

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private userService: UsersService) {}

  @Get()
  getUsers(): User[] {
    return this.userService.findAll();
  }

  @Get(':id')
  getUserById(@Param('id') id: number): User {
    return this.userService.findById(Number(id));
  }

  @Post()
  createUser(@Body() body: createUserDto): User {
    return this.userService.createUser(body);
  }
}
