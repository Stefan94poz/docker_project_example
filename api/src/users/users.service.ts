import { Injectable } from '@nestjs/common';
import { createUserDto } from './dto/create-user.dto';
import { User } from './entities/user.entity';

@Injectable()
export class UsersService {
  private users: User[] = [
    { id: 0, name: 'stefan' },
    { id: 1, name: 'milan' },
  ];

  findAll(): User[] {
    return this.users;
  }

  findById(userId: number): User {
    return this.users.find((user: User) => user.id == userId);
  }

  createUser(createUserDto: createUserDto): User {
    const newUser = { id: Math.random() * 1000, ...createUserDto };

    this.users.push(newUser);

    return newUser;
  }
}
